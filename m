Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2B865906F9
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 21:32:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234807AbiHKTcv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 15:32:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233439AbiHKTcr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 15:32:47 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF988915DB
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 12:32:46 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-32269d60830so183042027b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 12:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=KnZhSRmmnhV6NXnx60Qv/kbkELQWVsKuvSM9qoqa/sw=;
        b=a7cwYyQODPi/Md2tiwpSPJXrks/VkWThYOsbbcNH3vKWy3TnE/Gi0uAnM6KOBaxCS1
         aNCvVmKzPSxa++36Yb3m1kUEHJ6c9hN7l3SssTxDlXvllxy1XcWKcjWETCkwD+qTYFnD
         0sYuFBq8rOBdWiemISJeKUqTGOJY9Sy4b8Wvo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=KnZhSRmmnhV6NXnx60Qv/kbkELQWVsKuvSM9qoqa/sw=;
        b=1FZDkRGPdo98nYw969SWHMl8nmSH/5pCfJTD53hhXMA3EB/Y6lYh/KTYWhLpTCLhvl
         CBmnjXPEhHOnFSNZjMAiWxovTrJDpMlsRF7MMv4bnFIOJZ1vkfAgnZGizOraBR/3JJ5+
         0o8ZkBS/yi1kSnocRI6B3eNRQtCiEB3r+i0Ua/WHADu3LW31y9IKeDHYvqFAD2CO4YRT
         XnKQwPx+wBZ3QCnnmmiijMK5TKuApJh2ugZtaQPa+wl83KyYtz1UznlMkFySvwvmido+
         2AYJBvTQB4j0Qfba+Kwfuf+JX2BmBy+nKn1Gzl59r1Tf9PdmQC6KX+jP+I/nDlAJm8l+
         U4wg==
X-Gm-Message-State: ACgBeo2YhI5A+ZCxb/xClUbYCZ4hQ3V2Jce/evchA3eMicMeriuOo4Qw
        WNIVYBVte7laAJuLEq5JjTu3IW7FQzwjG+dJbH2wsw==
X-Google-Smtp-Source: AA6agR7R+/ZJPUr5AS/wPDpISVd1svxGA8bRr4yB/uEMC/Y+fldKYatkUgIcEhXzoDH4sNQSFv90bVEw0Tk41/UnT5E=
X-Received: by 2002:a81:81c1:0:b0:31e:7378:960c with SMTP id
 r184-20020a8181c1000000b0031e7378960cmr820348ywf.266.1660246366132; Thu, 11
 Aug 2022 12:32:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220803074955.v6.1.Ibf9efc9be50783eeee55befa2270b7d38552354c@changeid>
 <YuoRuP2pxgSQ6c9E@kroah.com> <CAONX=-f8kHWCEEyqUdpn5wsyMZKa4eJSSCLvPDn3R5mQF9FSMA@mail.gmail.com>
 <YvSfjwCu69ivTGIZ@sol.localdomain>
In-Reply-To: <YvSfjwCu69ivTGIZ@sol.localdomain>
From:   Daniil Lunev <dlunev@chromium.org>
Date:   Fri, 12 Aug 2022 05:32:34 +1000
Message-ID: <CAONX=-dK3CA2Tp2z+HrSTrR8=VJQuiFPhgoqKQkLhrDU1JXG5A@mail.gmail.com>
Subject: Re: [PATCH v6] ufs: core: print UFSHCD capabilities in controller's
 sysfs node
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bean Huo <beanhuo@micron.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Sohaib Mohamed <sohaib.amhmd@gmail.com>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric,
> This is describing the directory, so please include it in a documentation entry
> for the directory itself (/sys/bus/platform/drivers/ufshcd/*/capabilities/) just
> above the documentation entries for the files in the directory.

Should I keep the comment in this file as well, or remove it here when
adding to the documentation?

--Daniil
