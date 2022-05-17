Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 946B152AAF4
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 20:33:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245396AbiEQSdv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 14:33:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230121AbiEQSdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 14:33:47 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B477438BD1
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 11:33:46 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-d39f741ba0so25246335fac.13
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 11:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:cc:in-reply-to
         :content-transfer-encoding;
        bh=BVgnBkVfDm2XJACav0mU9wZpjFboktYYDIgw28DqJqM=;
        b=C93alRJskLKLZ6HYY/Wc25Wfsj8TfRN02GRZiQBGsn76rjaBAmuxZF75KPAObvDv78
         vRxB1TerY6qLOeaZPDXsl/ucJh8g9VebuNnX4Jqj+4Am4z+Wzct41IPpItFtUtMUVKER
         e0aXt/E0w0avg7WZ4Dlw94fCTRUof5nyAcEIVQPxFrW9LDOw6fJueO2fO92OyTMi7x+h
         ES+X4OoyKtJ8vpXEjDy+TlQC4l9Elag+6jbCvpmOrjag8E2RSYFhi6GamJiOi9qTV0/Q
         bb1PwgzRJVzSlQt9PeHXH4COMds8i3nM5HKM1DS9cjeGBL5rsfZuVVm27I51b5pv5FCa
         doKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:references:from:cc:in-reply-to
         :content-transfer-encoding;
        bh=BVgnBkVfDm2XJACav0mU9wZpjFboktYYDIgw28DqJqM=;
        b=Tnn3KMxjy/56/egcknqYs9oKdaS59qI8CXiANcFU+ihn4Hgxf+nVJgNKGpL4sQHoe6
         H0EM4PNixoOIRwnuYNkK2382MqVpTisOK8+VjoMK+3GgubsDChpdfzlh/cX2nQR4EDWl
         pdIuIkRX1NlBMwqBdzegmKb4WiU0JbzFLt6qtJMCGHo27DbHq6mYLZJL6jVjB4p8Ci8f
         FweFrA+VXg+2b3LPyJOch8k/T4XEG8cZrTifV4UmPAMF1h4psvXXmC098H5/V9CBD7Ic
         mBFgirAZ394G0JfCuO1IMCpoR2+Vy9+S0410uGSHcg4o9V0ZGvsgkbCD+nm3chjXQkEc
         oTtQ==
X-Gm-Message-State: AOAM533h0TS/Ao+pQESwIAwZb0TtJYmD5SOufTK2hdaUHmvV0RFNEfhE
        6SQB4wKvHMLobr2J2NVzhXY=
X-Google-Smtp-Source: ABdhPJxDDpCkpejHogmHDKuO2F4/XzREgJUwKtK3QSkkAP0ryl3NfMbDxyovPYaBTTtvJkBgAQ7ewg==
X-Received: by 2002:a05:6870:e3c1:b0:d7:2dc8:7fd0 with SMTP id y1-20020a056870e3c100b000d72dc87fd0mr13497036oad.104.1652812425847;
        Tue, 17 May 2022 11:33:45 -0700 (PDT)
Received: from ?IPV6:2603:8090:2005:39b3::100e? (2603-8090-2005-39b3-0000-0000-0000-100e.res6.spectrum.com. [2603:8090:2005:39b3::100e])
        by smtp.gmail.com with ESMTPSA id d3-20020a0568301b6300b006060322125fsm38854ote.47.2022.05.17.11.33.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 May 2022 11:33:45 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <a86d59b4-8f83-1f32-bd52-4662d407d745@lwfinger.net>
Date:   Tue, 17 May 2022 13:33:43 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: Changes in kernel 5.18-rc1 leads to crashes in VirtualBox Virtual
 Machines
Content-Language: en-US
To:     Vadim Galitsin <vadim.galitsyn@oracle.com>,
        "larry.finger@gmail.com" <larry.finger@gmail.com>,
        "Jason@zx2c4.com" <Jason@zx2c4.com>
References: <SJ0PR10MB5742C02D9F7F146A1313BD5DE9CE9@SJ0PR10MB5742.namprd10.prod.outlook.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
Cc:     LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <SJ0PR10MB5742C02D9F7F146A1313BD5DE9CE9@SJ0PR10MB5742.namprd10.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/17/22 12:27, Vadim Galitsin wrote:
> Hi Larry and Jason,
> 
> I am from VirtualBox team. I noticed your conversation here:
> 
> https://lore.kernel.org/lkml/Ym8uPcuQpq1xBS6d@zx2c4.com/T/#mea7aa731b5524a05ac3b3e8588c0c42235bb33d6 
> <https://lore.kernel.org/lkml/Ym8uPcuQpq1xBS6d@zx2c4.com/T/#mea7aa731b5524a05ac3b3e8588c0c42235bb33d6>
> 
> Please let me add my 5c. I agree with Larry, the issue start happen after 
> 6e8ec2552c7d. I did not do complete bisecting, but rather tried this revision 
> and the one before (with dcd03ba15947cbad1a34cfed370c4feb41058469 -- I do not 
> see the issue).
> 
> For me this issue is quite reproducible with Ubuntu 20.04 Linux guest (other 
> guests are also affected). It happens even if there is no VBox Guest Additions 
> installed into guest. Guest kernel version does not play much role. Running 
> kernel 5.18-rc1+ on the host side is essential.
> 
> The first way for me to reproduce it -- is to run stress-ng(1) tool inside guest 
> and perform random mouse cursor movements (basically, mouse or keyboard 
> interrupts generation is somehow essential here). Tool will report the following 
> error:
> 
> root@test-VirtualBox:~# stress-ng --vm 4 -t 10
> stress-ng: info:  [5463] dispatching hogs: 4 vm
> stress-ng: fail:  [5464] stress-ng-vm: detected 194065152 bit errors while 
> stressing memory
> stress-ng: error: [5463] process 5464 (stress-ng-vm) terminated with an error, 
> exit status=1 (stress-ng core failure)
> stress-ng: info:  [5463] unsuccessful run completed in 10.06s
> 
> This approach does not work in 100% cases, but triggers issue quite frequently.
> 
> The second approach is much more reliable for me. I basically, start compiling 
> kernel inside guest (say, with make -j4) and start moving mouse (or generate 
> keyboard interrupts, pressing keys randomly). In this case, gcc processes will 
> randomly receive SEGFAULT.
> 
> Important note: if I do not touch mouse or keyboard in both cases above -- all 
> works as normal.
> 
> My initial guess was that this might have something to do with kstack 
> randomization, but booting host kernel with randomize_kstack_offset=0 seem does 
> not change anything in this regard.
> 
> I am currently running out of ideas what exactly might trigger such behavior. 
> Hopefully, this additional info might shed additional light.
> 
> Best regards,
> Vadim
> 

Vadim,

I had an extended E-mail interchange with Jason Donenfeld over this issue. Sorry 
that most of this was private because some large files needed to be transmitted 
that were not appropriate for LKML. LKML is added back in to this reply.

My test for the fault was to start a VM running Windows 10 and use Edge to load 
the VirtualBox web page. Usually within a few seconds, Edge or Windows would 
crash. In the latter case, the log for the VM might show an unhandled exception 
while in kernel mode. I thought the browser was hitting the random number 
generator hard, but there is mouse activity, of course.

Jason has created a patch entitled "random: do not use input pool from hard 
IRQs" that fixes the problem for me. It can be found at 
https://lore.kernel.org/lkml/20220510140025.81168-1-Jason@zx2c4.com/. I had 
expected this patch to be merged into the mainline kernel by now. Jason should 
be able to shed light on any delays.

The bottom line and good news for Oracle/VirtualBox and those of us that package 
VB for distros is that this is a kernel regression - which is a conclusion I 
hesitated to make earlier. It is not a problem with VirtualBox, VB just exposes 
the kernel problem.

I certainly hope that this problem is fixed before 5.18 is released. If not, I 
will need to campaign to prevent openSUSE Tumbleweed from switching to 5.18. 
That would normally happen with the release of 5.18.1!

Larry

