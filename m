Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7AD74C951C
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 20:53:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235968AbiCATyD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 14:54:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234807AbiCATyC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 14:54:02 -0500
Received: from gateway23.websitewelcome.com (gateway23.websitewelcome.com [192.185.50.107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0BBE2459A
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 11:53:15 -0800 (PST)
Received: from cm10.websitewelcome.com (cm10.websitewelcome.com [100.42.49.4])
        by gateway23.websitewelcome.com (Postfix) with ESMTP id 372BB104DA
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 13:53:14 -0600 (CST)
Received: from gator4132.hostgator.com ([192.185.4.144])
        by cmsmtp with SMTP
        id P8YcnDZs9RnrrP8Ycn6tBF; Tue, 01 Mar 2022 13:53:14 -0600
X-Authority-Reason: nr=8
Received: from host-95-232-30-176.retail.telecomitalia.it ([95.232.30.176]:40048 helo=[10.0.0.45])
        by gator4132.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <bristot@kernel.org>)
        id 1nP8Yb-0018Dp-QQ; Tue, 01 Mar 2022 13:53:14 -0600
Message-ID: <9d346a5b-5763-0d82-c06d-a5802b3cb816@kernel.org>
Date:   Tue, 1 Mar 2022 20:53:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] tracing/osnoise: Force quiescent states while tracing
Content-Language: en-US
To:     paulmck@kernel.org
Cc:     Nicolas Saenz Julienne <nsaenzju@redhat.com>, rostedt@goodmis.org,
        mingo@redhat.com, linux-kernel@vger.kernel.org, mtosatti@redhat.com
References: <20220228141423.259691-1-nsaenzju@redhat.com>
 <137d3573-051f-5374-70d6-cc99b44d00da@kernel.org>
 <b604526d3186f6cd3da189abb70bd1ad9a6105c5.camel@redhat.com>
 <69e92bc6-0917-17e9-1b61-d884d30ba42c@kernel.org>
 <20220301180509.GQ4285@paulmck-ThinkPad-P17-Gen-1>
 <c3cf7c0c-27fe-4dfa-4249-a7e1747237a5@kernel.org>
 <20220301185823.GS4285@paulmck-ThinkPad-P17-Gen-1>
 <6fd678d8-58fc-5863-fd88-4c8335dd8b38@kernel.org>
 <20220301194601.GT4285@paulmck-ThinkPad-P17-Gen-1>
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
In-Reply-To: <20220301194601.GT4285@paulmck-ThinkPad-P17-Gen-1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4132.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - kernel.org
X-BWhitelist: no
X-Source-IP: 95.232.30.176
X-Source-L: No
X-Exim-ID: 1nP8Yb-0018Dp-QQ
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: host-95-232-30-176.retail.telecomitalia.it ([10.0.0.45]) [95.232.30.176]:40048
X-Source-Auth: kernel@bristot.me
X-Email-Count: 8
X-Source-Cap: YnJpc3RvdG1lO2JyaXN0b3RtZTtnYXRvcjQxMzIuaG9zdGdhdG9yLmNvbQ==
X-Local-Domain: no
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/1/22 20:46, Paul E. McKenney wrote:
>> But the idea is to see the noise for an user-space application as much as
>> possible (and no, I am not doing application in kernel... but I know people
>> doing it using a unikernel, but that is another story... a longer one... :-)).
> There have been people writing their applications in Linux kernel modules,
> or at least attempting to do so!  ;-)

I have to admit, I once made a kernel application to forward RTP packets for
VoIP communication, between FPGA/DSPs and network with zero-copy. Times were
others, 200MHz of CPU, a single AMBA bus to everybody... fun times :-) But that
is not the case anymore (phew).

-- Daniel
