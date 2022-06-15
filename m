Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC5CD54C1B0
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 08:22:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351653AbiFOGMe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 02:12:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235477AbiFOGMc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 02:12:32 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15D44192AF
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 23:12:31 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id x138so10494243pfc.12
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 23:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9Tdsc7ElAP0+huyaWwaYeur9yVzd2yI+7V/8yx/aIBc=;
        b=cLbNc3PAW59J4cj7Cb+E+uurhiCojwSgdCshxrzx/lLIQJaZiylX06qW0HYo8cMKe7
         EjJCA77ZwuPokDJt8wyixdlfI5Q5vbrF42Q3uZzBpT5ieD7uIq+4EeYm5LJavU/mqK7y
         JEyyUErnN+Phxr/OAtaT/Vhv+R3xqd0sUG92kSREMcoRQ5H6Jv3ZlEXLZ9mK82tcLuR3
         Ola+5DFuKW6zMXI7gQUh4XlV+SmjVbxFZCDOaOEtrkSAHMH2/z19fM+uLD35fwGCUd4H
         OeGHG60335MkX5CbugMYZokC3MBnkT4NOoTWQHmL18oSjBY1ctJNXksUUkQTaHIs5zbx
         iXmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=9Tdsc7ElAP0+huyaWwaYeur9yVzd2yI+7V/8yx/aIBc=;
        b=I0EUR4zqEoc3mY6jFaqrEvt/yWRnUFxlNFAFIWpOoVA1HS+68pbduokk7rXsb02KEm
         8QcVP04q0kI86UOLIOdxl9bLPj2hGz7dG3J2rk6waU/84XF+iQvgYBMVMYjEkqk1+wsl
         PUW1jH+amSipaSFuN7lQCTvTzxcrAxCIOmZOG/DAUVCsqkkvBEkM//VbUhd75IJe1wtp
         jSxmJEKJHbxHuWTqOn568wr0hdWS/NGKxsvVJS22Fys6WwfKdL1PC3tTBIlE+VuWLT2k
         ffNsdjPrDwhqgN5DY00eDUAdymrG0L1Wf8/Dn3gPrSA32/1z6w91i9P1R6ZttbTzQjE4
         Xy/A==
X-Gm-Message-State: AOAM5302U+3vDLjsV1dN0/t/772FluvLivxzDRBx6ivWTzbySJpGCOhM
        Tb3/ukeKTNzazXP1r7/YRrY=
X-Google-Smtp-Source: ABdhPJxfUICQhXQB6709mzdivAeSAnfNAjz10sNmqLBJvDbJkhwyOdBzhVj1+P4qXCtk4LpR3N6Rag==
X-Received: by 2002:a63:6806:0:b0:3fc:3b43:52d5 with SMTP id d6-20020a636806000000b003fc3b4352d5mr7576994pgc.319.1655273550299;
        Tue, 14 Jun 2022 23:12:30 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::4:7e4d])
        by smtp.gmail.com with ESMTPSA id n23-20020aa78a57000000b0051c01aa7d31sm8761660pfa.46.2022.06.14.23.12.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 23:12:28 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 14 Jun 2022 20:12:27 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Imran Khan <imran.f.khan@oracle.com>
Cc:     gregkh@linuxfoundation.org, viro@zeniv.linux.org.uk,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/4] kernfs: make ->attr.open RCU protected.
Message-ID: <Yql4S8+I8nDX0QA6@slm.duckdns.org>
References: <20220614070346.810168-1-imran.f.khan@oracle.com>
 <20220614070346.810168-2-imran.f.khan@oracle.com>
 <Yqi1RVRK2XahPWlg@slm.duckdns.org>
 <89ca35ba-0290-b155-b290-5e70efafa9bb@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <89ca35ba-0290-b155-b290-5e70efafa9bb@oracle.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 15, 2022 at 12:13:48PM +1000, Imran Khan wrote:
> Full patch-set will avoid this small conflict. I hope sending full
> patch-set is okay for this time. The full patch-set (v7) is available at [1]

It's just easier to focus on a single patch when repatedly iterating on it
like this. It's easy to repost the whole thing when the patch is settled. It
becomes a bit tiring to keep reposting essentially the same patchset over
and over again.

Thanks.

-- 
tejun
