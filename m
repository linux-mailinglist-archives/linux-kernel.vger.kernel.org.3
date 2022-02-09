Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D10D74AE87E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 05:12:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346643AbiBIEMm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 23:12:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347515AbiBIDvD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 22:51:03 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A910C061578;
        Tue,  8 Feb 2022 19:51:00 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id n32so1991213pfv.11;
        Tue, 08 Feb 2022 19:51:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=HRdPwXuWMTu44Hbd31o0zplR0BavrSo2F1orInPcfp8=;
        b=cW5KWjK/tnZxVtckN0ujtQlJnhull6OIFZNKosetMnPdwE3H1iHp35lk8pXmEtdHEV
         byHtfb+A8nHQgRGmpr9C5QwBE9eSRLSNK/To89h9+2xa9GU3cCWOwhWOXxgPjzdfEio/
         V/WaMj8/bN97MTF7j8qqtR0b1SBdJV/acCBcSu42VfIMtqqf3EZGZmnDw+fs36NLdQ2O
         pH09il0jwei6t2ONP3qNwmZODxET3tkPE753IrZxdnJdFqUhuusWZyl40Dz2LLV1cqzL
         42iei88+m0MEnaDOgLqP7erD8jxup0bFVLWS5+Fyv0OyGSTgCJKLAxOTyPldsxOMPlzv
         Pj9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=HRdPwXuWMTu44Hbd31o0zplR0BavrSo2F1orInPcfp8=;
        b=W1ntQnitLKzXp1YglWH0S7k49Dz5nHeLkjuocS3RN5hJ2MLlYm78TnxBnDy08REkBS
         oWipfeJIkD+y623aQuLlXR/E0WWPt0qbn4tfpclWzav65b07oHgsx4wjzZsU+ovukO+z
         fSXb8QolqCrqWQJbyccUYfjuerdg5af8k10/BvmGh+OKCZ4pqAKk1Ywr4NhRf0gHuFry
         W4gBzCtdWtserL08wZG3lV/4A2xLOJRKCL7HzidpLXSilY4XrVofIwp95RsZ0YSkQOhT
         g/oyDsFZkXVvZaDuzuhna6w5ZWBU69iNj6x9X0IZKNIIZBSZsMQj+fkokA7iEs77kdRM
         RZ7g==
X-Gm-Message-State: AOAM531EknoYgk+qEVSHEXSTkA9TA1dnvVM37+c31J03IurShDiRUygg
        1U27BYA6WoMj8q3+Pr0/ikcecxvaBJY=
X-Google-Smtp-Source: ABdhPJymSo30+5Ud2M4FxOnfKpR4Yr9Ce08b2ReafFmvyQjEDUryhQkWvhHck/SXLVaOE/vnQBaFVQ==
X-Received: by 2002:a63:2c05:: with SMTP id s5mr430675pgs.106.1644378660080;
        Tue, 08 Feb 2022 19:51:00 -0800 (PST)
Received: from [10.73.0.6] ([45.128.198.44])
        by smtp.gmail.com with ESMTPSA id l2sm4216426pju.52.2022.02.08.19.50.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Feb 2022 19:50:59 -0800 (PST)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [BUG] usb: typec: ucsi: possible deadlock in ucsi_pr_swap() and
 ucsi_handle_connector_change()
To:     heikki.krogerus@linux.intel.com,
        Greg KH <gregkh@linuxfoundation.org>, kyletso@google.com,
        jackp@codeaurora.org, andy.shevchenko@gmail.com,
        unixbhaskar@gmail.com, subbaram@codeaurora.org,
        mrana@codeaurora.org
Cc:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <037de7ac-e210-bdf5-ec7a-8c0c88a0be20@gmail.com>
Date:   Wed, 9 Feb 2022 11:50:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

My static analysis tool reports a possible deadlock in the ucsi driver 
in Linux 5.16:

ucsi_pr_swap()
   mutex_lock(&con->lock); --> Line 962 (Lock A)
   wait_for_completion_timeout(&con->complete, ...) --> Line 981 (Wait X)

ucsi_handle_connector_change()
   mutex_lock(&con->lock); --> Line 763 (Lock A)
   complete(&con->complete); --> Line 782 (Wake X)
   complete(&con->complete); --> Line 807 (Wake X)

When ucsi_pr_swap() is executed, "Wait X" is performed by holding "Lock 
A". If ucsi_handle_connector_change() is executed at this time, "Wake X" 
cannot be performed to wake up "Wait X" in 
ucsi_handle_connector_change(), because "Lock A" has been already held 
by ucsi_handle_connector_change(), causing a possible deadlock.
I find that "Wait X" is performed with a timeout, to relieve the 
possible deadlock; but I think this timeout can cause inefficient execution.

I am not quite sure whether this possible problem is real.
Any feedback would be appreciated, thanks :)


Best wishes,
Jia-Ju Bai
