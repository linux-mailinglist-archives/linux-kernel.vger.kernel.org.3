Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 127A54E6A30
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 22:20:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355168AbiCXVVk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 17:21:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355160AbiCXVVf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 17:21:35 -0400
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0845A58829;
        Thu, 24 Mar 2022 14:20:02 -0700 (PDT)
Received: by mail-ot1-f50.google.com with SMTP id i23-20020a9d6117000000b005cb58c354e6so4193855otj.10;
        Thu, 24 Mar 2022 14:20:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=nZWBFSxF5EcD/7zsReIxioOFi/XH9lIHO9AjBk+DuYQ=;
        b=nE9Ow8k5hgST1QdGtELUdJ8kKHfSfPGRUplZWzHdvjV3GY8jr/Ccl95o9YXY76oHFQ
         mmyXX+U7h/KbwVVesDr/rqKmOaLub8ER5oWVV0NfslO/DE8lrBFH5C/mYCdmf/yyxzPk
         BuwOEGsiHFDKE3vsjkPf0hlEtDQYrBzUwh9JhNLKhP96TBMfatvMopvWf9gkWrwxiXhv
         1qqtmpxRsElsiHoOlC5oz735+D/6OvMhSLNzSAmzQjTATrtgQz6kOOKgo4vjMhM5LPjW
         XTTCzHQgCnBGRqZjRxAz8+xvPq4dE3/q5DuU36RCjGfpiALMzRPQDfzTk9lit6wHSYtU
         ex4w==
X-Gm-Message-State: AOAM5311zvWso6A/iItgK707GXHoPum5nhNWsYHoU16otWmV18HjZ3Nl
        NuO/rM9yzJFs0/Al5yA2lQ==
X-Google-Smtp-Source: ABdhPJyODYrocQIME0OAE9G5smC2auk9j+xSOw5TB2oty2nbpPQU2zFSF3ULc0wpM/GONsqTcT7sJw==
X-Received: by 2002:a9d:7319:0:b0:5cd:121e:e11 with SMTP id e25-20020a9d7319000000b005cd121e0e11mr3043744otk.148.1648156801286;
        Thu, 24 Mar 2022 14:20:01 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id t10-20020a056830224a00b005cd9db03fabsm1806726otd.78.2022.03.24.14.19.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 14:20:00 -0700 (PDT)
Received: (nullmailer pid 2592144 invoked by uid 1000);
        Thu, 24 Mar 2022 21:19:59 -0000
Date:   Thu, 24 Mar 2022 16:19:59 -0500
From:   Rob Herring <robh@kernel.org>
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc:     "jason-jh.lin" <jason-jh.lin@mediatek.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Fei Shao <fshao@chromium.org>,
        Moudy Ho <moudy.ho@mediatek.com>,
        "roy-cw.yeh" <roy-cw.yeh@mediatek.com>, CK Hu <ck.hu@mediatek.com>,
        Fabien Parent <fparent@baylibre.com>,
        Nancy Lin <nancy.lin@mediatek.com>, singo.chang@mediatek.com,
        DTML <devicetree@vger.kernel.org>,
        "moderated list:ARM/STM32 ARCHITECTURE" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: Re: [PATCH v2 0/4] Fix MediaTek display dt-bindings issues
Message-ID: <Yjzgf10zAhrkpYde@robh.at.kernel.org>
References: <20220309134702.9942-1-jason-jh.lin@mediatek.com>
 <CAL_Jsq+=hTKTjB8rR77_uQYKDWHzLyTdeU7zbixSCZCNrdmNvg@mail.gmail.com>
 <CAAOTY__kzL8YuGo-oKct4c_bL-Ch5rW8wBpkhOXkK+a10gNXVg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAOTY__kzL8YuGo-oKct4c_bL-Ch5rW8wBpkhOXkK+a10gNXVg@mail.gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 24, 2022 at 09:25:44PM +0800, Chun-Kuang Hu wrote:
> Hi, Rob:
> 
> Rob Herring <robh@kernel.org> 於 2022年3月23日 週三 下午10:10寫道：
> >
> > On Wed, Mar 9, 2022 at 7:47 AM jason-jh.lin <jason-jh.lin@mediatek.com> wrote:
> > >
> > > The vdosys0 series carried a nice dt-bindings conversion of the old
> > > txt documentation for the entire mediatek-drm driver, but some of
> > > the issues in there weren't seen.
> > >
> > > This series is fixing all of the issues pointed out by a
> > > `dt_binding_check` run, followed by `dtbs_check`.
> > >
> > > Change in v2:
> > > - remove mediatek,ethdr.yaml file
> > > - change include header of mediatek,ovl-2l.yaml from mt8173 to mt8183
> > >
> > > AngeloGioacchino Del Regno (3):
> > >   dt-bindings: display: mediatek, mutex: Fix mediatek, gce-events type
> > >   dt-bindings: display: mediatek, ovl: Fix 'iommu' required property
> > >     typo
> > >   dt-bindings: display: mediatek: Fix examples on new bindings
> > >
> > > jason-jh.lin (1):
> > >   Revert "dt-bindings: display: mediatek: add ethdr definition for
> > >     mt8195"
> >
> > Can this series get applied soon? linux-next is still broken.
> >
> > If it hits Linus' tree, I will be applying them.
> 
> I've applied this series to my tree [1], but now is merge window, so I
> plan to send this series through Dave's tree after 5.18-rc1. Would
> this be too late for you?

Yes, people base their development on -rc1 and it would be nice to have 
a functional tree.

There's not really any need to wait to send fixes.

Rob
