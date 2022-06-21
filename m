Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72FBB552C50
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 09:48:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347319AbiFUHrP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 03:47:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344495AbiFUHrM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 03:47:12 -0400
X-Greylist: delayed 2655 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 21 Jun 2022 00:47:09 PDT
Received: from esgaroth.petrovitsch.at (unknown [IPv6:2a01:4f8:120:527b:6876:2a4f:a044:62ad])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32B0723BCA
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 00:47:09 -0700 (PDT)
Received: from [172.16.0.14] (84-115-219-246.cable.dynamic.surfer.at [84.115.219.246])
        (authenticated bits=0)
        by esgaroth.petrovitsch.at (8.17.1/8.17.1) with ESMTPSA id 25L72lm63449013
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT);
        Tue, 21 Jun 2022 09:02:48 +0200
DKIM-Filter: OpenDKIM Filter v2.11.0 esgaroth.petrovitsch.at 25L72lm63449013
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=petrovitsch.priv.at;
        s=default; t=1655794968;
        bh=YZ81fjTKo/UYSEbtnBxZUB9g2m46rZ2UpolJeNl5ia0=;
        h=Date:Subject:To:References:Cc:From:In-Reply-To:From;
        b=Bh5SKEUPFNJgHy+Ujp6DQTYjh+RjlpP0kpxaQgdAw6CGJ0NHAG4CKedqzUwSNRqPG
         18llQNELXUgd+LGLOIGyQFdzpA2LDoIM7Nf5wmDqIvWy11FNUpybUwfPjk9KNmiCVr
         HtTm02d0bZoMBef+D7di1t6oePszRz6Q0rBw48K8=
X-Info-sendmail: I was here
Message-ID: <b6d8611a-714c-4fb0-5027-584884bb66a1@petrovitsch.priv.at>
Date:   Tue, 21 Jun 2022 09:02:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: Networking Question
Content-Language: en-US
To:     "Ryan P. Nicholl" <rnicholl@protonmail.com>
References: <6_nVwntZEyEq2Gn0PYDz5w_yuD20E9Je_Bk2rJHsOersGq3v2x3_6hXnyjNm-X83-OTl1KKo4eLoHzyBVM_nzCcDrpPtz4dz3_71A3QezfI=@protonmail.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>
From:   Bernd Petrovitsch <bernd@petrovitsch.priv.at>
BIMI-Selector: v=BIMI1; s=default
In-Reply-To: <6_nVwntZEyEq2Gn0PYDz5w_yuD20E9Je_Bk2rJHsOersGq3v2x3_6hXnyjNm-X83-OTl1KKo4eLoHzyBVM_nzCcDrpPtz4dz3_71A3QezfI=@protonmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DCC--Metrics: esgaroth.petrovitsch.priv.at 1102; Body=2 Fuz1=2 Fuz2=2
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_20,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all!

On 21/06/2022 02:29, Ryan P. Nicholl wrote:
> I've been unable to find any Linux API for asynchronously waiting for the TCP send buffer to drain.
> 
> The problem I have, in a nutshell, is noted in this part of the documentation:
> 
>         If fildes refers to a socket, close() shall cause the socket to
>         be destroyed. If the socket is in connection-mode, and the

That's not really a Linux kernel question as such (because that should 
work that way on all TCP connections anywhere) but the shutdown() 
syscall is probably what you need:
- your side shuts down the sending part of the socket.
- the other side reads data and gets eventually EOF
- the other side call shutdown() for it's sending side when it's done.
- your side gets EOF.
And then your side knows that no data is in flight.
- finally, you clean up with close(). You can shutdown() the receiving
   side too but doesn't change anything.

[ deleted SO_LINGER stuff - that's for something completelly different ... ]

Kind regards,
	Bernd
-- 
Bernd Petrovitsch                  Email : bernd@petrovitsch.priv.at
      There is NO CLOUD, just other people's computers. - FSFE
                      LUGA : http://www.luga.at
