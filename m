Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 906F94D15AE
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 12:07:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346213AbiCHLH5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 06:07:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242129AbiCHLHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 06:07:55 -0500
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1895D45059;
        Tue,  8 Mar 2022 03:06:59 -0800 (PST)
Received: by mail-ed1-f43.google.com with SMTP id y12so4208628edc.13;
        Tue, 08 Mar 2022 03:06:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:from:subject:content-transfer-encoding;
        bh=UBEfcUeXOl6T8RYX0TXPmII0+ljclksH8bH/f8fmMoA=;
        b=s2BMLXST++YE2gBOYxCj78WBNIW6ii5mTyhiIqSryBCpIrSyX9ycQAxRfWP6bbQAwp
         z0XFNag+Unv4C8t22AmN51vy2F2E+u6/UYQBMMG6QpKArkryCPqM0sb/lCt71k6Oq6b2
         cfJNgfsgVnv7kWa4EDBsH8KR7ZqvHzfDdDRHbbeY3W6/DDq3aaAE5DB0RUy5tOMKiTaA
         LrJDH6EQUh3mlzPmQFlDzaLboC9hs9DnsBJ9S+JyRm2VdTO6CnhdNoKXWVNNIyOKQclT
         SUTdngu4Drk07qJg6KFnPmjoFe5VD3rV7XqD7ou6IvnfWqmMy8Q+e5kSeWkpY+yI0D2X
         QFoA==
X-Gm-Message-State: AOAM5334oxv4HM42nHISX++hCVKk7fznurHGSItANXIWuvHiw4OzfnOW
        NNWiynMWbd+eSCKPdkjfempCGNBVwVk=
X-Google-Smtp-Source: ABdhPJwGR7oB7lqphuthKLr5kn93jbunQA5BEbq8HBuYq1hgJl5Yu4nN1v0l2teCTzFnxqb1zL9Vog==
X-Received: by 2002:a05:6402:b78:b0:416:171e:835d with SMTP id cb24-20020a0564020b7800b00416171e835dmr15340066edb.270.1646737617552;
        Tue, 08 Mar 2022 03:06:57 -0800 (PST)
Received: from ?IPV6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id z15-20020a170906240f00b006d703ca573fsm5690446eja.85.2022.03.08.03.06.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Mar 2022 03:06:56 -0800 (PST)
Message-ID: <d2713ae1-0ca5-9e5a-b7d2-b7d0f1f5614a@kernel.org>
Date:   Tue, 8 Mar 2022 12:06:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Content-Language: en-US
To:     Helge Deller <deller@gmx.de>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        linux-parisc@vger.kernel.org,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
From:   Jiri Slaby <jirislaby@kernel.org>
Subject: hppa vDSO and compiler (non-)support
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

since the "parisc: Add vDSO support" commit, I can no longer cross-build 
a hppa kernel. I see two issues:

1) CROSS32_COMPILE detection doesn't work here, as openSUSE provides 
hppa-suse-linux-* binaries. It's easy to overcome by 
"CROSS32_COMPILE=hppa-suse-linux-"

2) openSUSE doesn't provide any libc for hppa. So gcc doesn't provide 
libgcc.a and the build of vDSO fails.

So could vDSO be optional on hppa via KConfig?

I used to use the cross compiler to at least compile-check the following 
  tty drivers:
arch/parisc/kernel/pdc_cons.o
drivers/tty/serial/mux.o
drivers/tty/serial/8250/8250_gsc.o

thanks,
-- 
js
suse labs
