Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C98A55E6DB
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 18:31:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348040AbiF1Py5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 11:54:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231159AbiF1Pyy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 11:54:54 -0400
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 943112EA08;
        Tue, 28 Jun 2022 08:54:53 -0700 (PDT)
Received: by mail-yb1-f176.google.com with SMTP id o19so16404921ybg.2;
        Tue, 28 Jun 2022 08:54:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M2M/nWMIArWh6jatNaLmjqxVllqrja+AOnsO6CfEGJk=;
        b=mtCmM3JiPfD/6bpZEZijrDLFXlqm6XNZnzWlMz7DacAbGOpklNYAxN8RVULsku9KHh
         9zA2qbMdLlouLDnIDDyzl2gOtxiRTR/tne3GW0De7MbGXKwBAjX3zNhSrP+FoCdhfYTE
         6q51GIyLasFNBHnn3TgHrWS/fUS6ZJCRCmVMzDUwJw3pW/yyNtm60lz8aYxwBxXIw9ca
         czcBI1/jZXbswHHxC2n4A0EB9qc2LCR50iDZa6iQoaAYm5/ZpHKL0Ns7/POyX51J4EYW
         H71OWMBln1zB6jEe1kSttJjWn4Zfo6WkbEtTQA0dIdhO0rB4aGdCmp/0GcgbNI7Pk3uP
         qMRw==
X-Gm-Message-State: AJIora9U1NO1Z545QNt8HW5KDgXBWuj8iZXVeSHRSplbs+SKowPSied+
        fRUhKovDePZp3oojyiwUHGiqY6qu8ku1226JgZY=
X-Google-Smtp-Source: AGRyM1v35HaVSm8aGnI7ET9CfTgX4A2FHre43lUkb7LAgas5M9aN2OgQHgFB+2vu3UVCEj1r+eu3tSjcm/Nu5ocohJc=
X-Received: by 2002:a25:9847:0:b0:669:b4c6:d081 with SMTP id
 k7-20020a259847000000b00669b4c6d081mr19508238ybo.633.1656431692627; Tue, 28
 Jun 2022 08:54:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220613120755.14306-1-peter.wang@mediatek.com>
 <CAJZ5v0ipi5frHBGWWcFpGCYL7au=dF6vUG772h0r0pnCYsi5Zg@mail.gmail.com> <028eba89-8176-740f-42df-736a0fcf26e7@mediatek.com>
In-Reply-To: <028eba89-8176-740f-42df-736a0fcf26e7@mediatek.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 28 Jun 2022 17:54:41 +0200
Message-ID: <CAJZ5v0g7kuD9CNBUv+9CuthX79Sq01_e4DQAvbUqFPKsMYkedA@mail.gmail.com>
Subject: Re: [PATCH v1] PM-runtime: Check supplier_preactivated before release supplier
To:     Peter Wang <peter.wang@mediatek.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Avri Altman <avri.altman@wdc.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        wsd_upstream <wsd_upstream@mediatek.com>,
        "moderated list:ARM/Mediatek SoC..." 
        <linux-mediatek@lists.infradead.org>, chun-hung.wu@mediatek.com,
        alice.chao@mediatek.com, cc.chou@mediatek.com,
        chaotian.jing@mediatek.com, jiajie.hao@mediatek.com,
        powen.kao@mediatek.com, qilin.tan@mediatek.com,
        lin.gui@mediatek.com, tun-yu.yu@mediatek.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 28, 2022 at 3:53 AM Peter Wang <peter.wang@mediatek.com> wrote:
>
>
> On 6/28/22 3:00 AM, Rafael J. Wysocki wrote:
> > On Mon, Jun 13, 2022 at 2:08 PM <peter.wang@mediatek.com> wrote:
> >> From: Peter Wang <peter.wang@mediatek.com>
> >>
> >> With divice link of DL_FLAG_PM_RUNTIME, if consumer call pm_runtime_get_suppliers
> >> to prevent supplier enter suspend, pm_runtime_release_supplier should
> >> check supplier_preactivated before let supplier enter suspend.
> > Why?
>
> because supplier_preactivated is true means supplier cannot enter
> suspend, right?

No, it doesn't mean that.
