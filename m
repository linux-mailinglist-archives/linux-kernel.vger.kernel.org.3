Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF3CE5AE4F6
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 12:02:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233788AbiIFKCN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 06:02:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234047AbiIFKBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 06:01:31 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD0BD786E6;
        Tue,  6 Sep 2022 03:01:06 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id p1-20020a17090a2d8100b0020040a3f75eso5939463pjd.4;
        Tue, 06 Sep 2022 03:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=YKSHnIDLbk0AOTJw59kitMI5uEp3xXvtgpVkSTjCkzM=;
        b=H4kMv845J9bYxtEKRZDhNBqclS6L0jLOyG2wkW9mw1r6JHSUY/loXrG7v9/6KXbFhC
         LIgwRkq+DG8+eR3EhVLg+eaBusmwi7B+Wra6hTbnNpaqmgHjt+H7fRP8DkaF0azLhZLK
         OEijzWDlZ1FyOzrSDGNsS4LTkrDTb7I3ZyfioHeslVHHOL0HoinNfpz7FKt+PV2Xzlts
         ihLo5dnospLa23Lo2RP8wxxSLlX4JzRhW36NgS7ddt1cBntwaQKHFaxPqsk+3zFdorKq
         E3Im6vhSB1NH3jwXioIma4Qq6jyFQTVhNkAizUB8utpzg/aQeCVdxBXV8eQL/pEKnW98
         tBuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=YKSHnIDLbk0AOTJw59kitMI5uEp3xXvtgpVkSTjCkzM=;
        b=G63MyYUk1goP/6kOFIYjXG7/R/MRSbV2X/QAs7kXP7MseHb3ybZNbxbEzvGgY2xQ6k
         8B3ndyz3sKQa5ukGNVHK1vOsRE3ypyth6H79r4wLTLhDaCasPOHZFnL+fTVVeDZwSrO2
         tEqc6yzWZgp4qQ+jYUR7jRl8KiMd5ztWyHJxi9wCuqbyH5O/8eZA4O6oIx20axZioymp
         KlAGT6F7CXEXWLgj2cHRkEX9fqlfG3kvrr2Lv/a/v3UZxsJf9oe4mFQqv8wrE6xX/5Ps
         BeclZj1G7GBOXC/880UW04DvbwVheFk2Lnk72T9EZIsvoqSqB0kGr4/pi0dAyCCAJoOc
         DDrw==
X-Gm-Message-State: ACgBeo0Jb+aV6rJWigoDa58d6HTUe3LSScIm50zLBrt96uc0fNDSDQU6
        1g4mi5RAmj+fgnMXCT8b4AQ6sLbsd+zA9FZSnhw=
X-Google-Smtp-Source: AA6agR46YAPLjMSYp7Kanoo0p3TW1lBtmX3+X7oA6gNMSU+WNlt0CEM4uGqfh6I6eB99C87Z8N2NMj2CSl61ps815CQ=
X-Received: by 2002:a17:90a:1d0:b0:1fa:c551:5e83 with SMTP id
 16-20020a17090a01d000b001fac5515e83mr23953494pjd.106.1662458466109; Tue, 06
 Sep 2022 03:01:06 -0700 (PDT)
MIME-Version: 1.0
References: <20211112120641.16073-1-fantasquex@gmail.com> <DM6PR18MB303406C9CF97E2B42CEC63ACD2499@DM6PR18MB3034.namprd18.prod.outlook.com>
In-Reply-To: <DM6PR18MB303406C9CF97E2B42CEC63ACD2499@DM6PR18MB3034.namprd18.prod.outlook.com>
From:   Letu Ren <fantasquex@gmail.com>
Date:   Tue, 6 Sep 2022 18:00:54 +0800
Message-ID: <CAEUwDuD0ZMNqwdi-zkH_s7Gj6SkSJpvrcVzhtMz_1HRrXN=dpA@mail.gmail.com>
Subject: Re: [EXT] [PATCH] scsi: qedf: Fix a UAF bug in __qedf_probe
To:     Saurav Kashyap <skashyap@marvell.com>
Cc:     Javed Hasan <jhasan@marvell.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        GR-QLogic-Storage-Upstream <GR-QLogic-Storage-Upstream@marvell.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Zheyu Ma <zheyuma97@gmail.com>, Wende Tan <twd2.me@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Saurav,

> Thanks for the patch.
>
> Acked-by: Saurav Kashyap <skashyap@marvell.com>


This is a friendly reminder. I wonder the review progress of this
patch. Almost a year has passed since I submitted the patch. And we
have tested qedf on Linux 6.0-rc0. This UAF problem still exists. If
there's anything I can do to help with this issue please let me know.
I'm willing to help.

Letu Ren
