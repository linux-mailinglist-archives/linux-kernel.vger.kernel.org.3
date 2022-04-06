Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D76F4F694D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 20:19:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240512AbiDFSPP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 14:15:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240487AbiDFSO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 14:14:56 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C33D4239313;
        Wed,  6 Apr 2022 09:52:38 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id h11so4069758ljb.2;
        Wed, 06 Apr 2022 09:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hivMJCrPDEZ4f+6hmVn6hj8p1TUlQCQz9AqY1gEV4jw=;
        b=hACzY332OhkbK68D5QIPTEzAVPoRFXE8oksSkVa9KtQBEdACNqGv72zJEHLEI9QZXM
         5QbmA8jMYkJAMi6wxongOZTVHNuxKsQzpl93lNvMqD+v361Bl2v1ughzSO3jjiy0zxFq
         MizUaFtb9P8OElMN3GdLUk5Ip4XauCy6D5JePUfqKonY0w4LDDCF1tzvLJQqsda70lv5
         gYK7y3Lzv0sl81d1wGpL9v/a3kt9bO4nRouZRxAXPmLxgtv8gG8QRUPgFcq2CQDaITSr
         9SkrFbz8AfeNW7avb566/PPsHGBqO6BnSJsg3b7Fc0w2MZv0GGPgmP3NDX8pl6V0nY7H
         W3lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hivMJCrPDEZ4f+6hmVn6hj8p1TUlQCQz9AqY1gEV4jw=;
        b=WKPGK/pVvjQMJrYSDF1bF0LgeJHMaGlW6JoRwTJJeJSvMnksi4HiJM+9+lkZxvgZSC
         /EdNoZAmdih/l5i/Utq6GyuKPm7++W/fZ1E8v98SEdc8byrk0YR1qLLkp54PHCWCsGqC
         l0Yi3Y9N5ErG7Uvgii7uZde9TlN2714vfFpkgfwMFc8gLQ9M3ZT+Q3NOV+mguF9G2Wd8
         HiWKUaVtGVZ+RVMxQtv4KtmjZkIuKu+3aE/mSkaDuEBpqOUXcKyXuisF+2TQCQ1yuGId
         Zz3WHAcrcnhirqoDvMZvu3x3APBLbl1GcT6rT3IeNC7JHfoq70p+ZVfGuoiZd9Dw3Npm
         B8Rw==
X-Gm-Message-State: AOAM532c2fC/HMrOkM4oRoRRLUH0DkoT35bhQFpxro21EvBWx/NVPpO2
        5ed6ij9f4IFEt4g+HfpY+EA=
X-Google-Smtp-Source: ABdhPJzVbE2XPzujOfnuB8RNCRrD7x9ttQeAciO1x5BAFgV/ApAg7IheulSAKOAU4qCPuEQLGzyqog==
X-Received: by 2002:a2e:9e43:0:b0:24b:3c6:3832 with SMTP id g3-20020a2e9e43000000b0024b03c63832mr5707412ljk.63.1649263956916;
        Wed, 06 Apr 2022 09:52:36 -0700 (PDT)
Received: from reki (broadband-95-84-198-152.ip.moscow.rt.ru. [95.84.198.152])
        by smtp.gmail.com with ESMTPSA id k19-20020a056512331300b0044a8470fe29sm1883995lfe.19.2022.04.06.09.52.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 09:52:35 -0700 (PDT)
Date:   Wed, 6 Apr 2022 19:52:34 +0300
From:   Maxim Devaev <mdevaev@gmail.com>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     linux-usb@vger.kernel.org, Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Cai Huoqing <caihuoqing@baidu.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: gadget: f_mass_storage: break IO operations via
 configfs
Message-ID: <20220406195234.4f63cb4a@reki>
In-Reply-To: <Yk2wvhSTMKTLFK6c@rowland.harvard.edu>
References: <20220406092445.215288-1-mdevaev@gmail.com>
 <Yk2wvhSTMKTLFK6c@rowland.harvard.edu>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> It's not clear to me how breaking I/O operations allows you to do a 
> "force eject".  It seems that what you would need is something like 
> fsg_store_file() that omits the curlun->prevent_medium_removal check.
> Interrupting a lengthy I/O operation doesn't really have anything to do 
> with this.

Perhaps I chose the wrong path, it's just how my userspace code works now.
If the drive is connected to a Linux host, then in order to clear
the "file" and extract the image, I sent a SIGUSR1 signal to the "file-storage"
thread. This interrupted long IO operations, reset curlun->prevent_medium_removal
and I got the ability to extract.

It was done in our KVM-over-IP project and worked for several years,
just now I want to do it without searching for procfs and the need
to use sudo helpers like this:
https://github.com/pikvm/kvmd/blob/1b3a2cc/kvmd/helpers/otgmsd/unlock/__init__.py

Maybe it's worth introducing some option that will allow us to ignore
curlun->prevent_medium_removal and perform a forced extraction?
Something like "allow_force_eject" on the same lavel with "stall".
Will masking the curlun->prevent_medium_removal flag be enough?

> Or to keep this ability restricted to the superuser, if that is desired.

Indeed.

> You should not call send_sig_info() directly; instead call 
> raise_exception().  It already does the work you need (including some 
> things you left out).

raise_exception() assumes the setting of a new state, and I did not want to do this,
since the same does not happen when throwing a signal from userspace.
