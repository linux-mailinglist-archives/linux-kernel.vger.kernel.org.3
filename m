Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01F93510C0B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 00:26:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355824AbiDZW3Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 18:29:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355813AbiDZW3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 18:29:23 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6A947DE05
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 15:26:14 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id m13so457026iob.4
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 15:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XGlGbLh6bEnbqOguFAazlvyQUWTc8WoVl/XZIwb2vyg=;
        b=KhX8zq4519Alh989oGQbOZ5TD0FfPavnroKpD1epUR5av138znn1aeOTaIy9SwywYV
         cN2kt/OEAwASJYsLDLLfqQkBCYhXt44Oq96SrBBtj0p+SVtCUGlwfw7Pd5mK2ZyR5JQz
         T/rHz34Txh87pT+3eCq/JxYnzUC+lIdBV8UGE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XGlGbLh6bEnbqOguFAazlvyQUWTc8WoVl/XZIwb2vyg=;
        b=uei0v/gq5JauhRvWtxqpXgXBlQuRcESOrpFmqFuuEAuk+p24US6rt2JxizY4ZjnFJi
         IN5DAnU+cEtycnlBXjdsDM3WExcln4utIb/odpT9ros8jbKgwSbkDOdMauTqIqMC01Rz
         /CUIsrT4PhZy/ZPpeD3DVJHCyBW2tAsHBOotEk3UgY3tFDlTaR+N/7lcTsguYUnxhwEL
         f+4PO27SM2J7qa8JMEYoYko/R7noUayGIS75SmSlMEHWd1J8MCAq5yhN9mQkc1iK4ti+
         mRxjtZs5Ep/JK56bSdKwKqNFe/npa00L5HYUBUAf07SWTeW+6nNQ10IHNfLidTPEQ8UU
         yrEg==
X-Gm-Message-State: AOAM53063ykvYYMFZeGOnFCQmT4tqPHKruORjlspA+65Yo1SDTgVRNlJ
        F1AgCO256h/aQIVz1EfrQyhzmQmjkofgw+FNImVUeIf60H0=
X-Google-Smtp-Source: ABdhPJy3moSd+V0OFpev/Wt0vtSGfTMg2CNNKnetIpazSzWmk9Bz3+Qal22zLcONmUG7ZARSZKv9onHgxNQtZMAMe6I=
X-Received: by 2002:a05:6e02:2190:b0:2cd:8a7d:2d8 with SMTP id
 j16-20020a056e02219000b002cd8a7d02d8mr6141006ila.28.1651011973871; Tue, 26
 Apr 2022 15:26:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220425021442.1.I650b809482e1af8d0156ed88b5dc2677a0711d46@changeid>
 <f429219f-e5e5-6107-473f-a4566f4e7ee1@quicinc.com> <71858a31-4667-b358-194c-95a2ffc0c593@quicinc.com>
In-Reply-To: <71858a31-4667-b358-194c-95a2ffc0c593@quicinc.com>
From:   Abhishek Kumar <kuabhs@chromium.org>
Date:   Tue, 26 Apr 2022 15:26:01 -0700
Message-ID: <CACTWRwtUMFjw4vnDZVEXvGB5kH2KhJr5fwcXZn7TMan73OtOHA@mail.gmail.com>
Subject: Re: [PATCH] ath10k: skip ath10k_halt during suspend for driver state RESTARTING
To:     Jeff Johnson <quic_jjohnson@quicinc.com>
Cc:     kvalo@kernel.org, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org, briannorris@chromium.org,
        ath10k@lists.infradead.org, netdev@vger.kernel.org,
        Wen Gong <quic_wgong@quicinc.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Addressed all the above comments and pushed out a v2 patch. Fixes in V2:
- Fixed typo, replaced ath11k by ath10k in comments.
- Adjusted the position of the S-O-B tag.
- Added tested on tag.

Thanks
Abhishek

On Tue, Apr 26, 2022 at 9:23 AM Jeff Johnson <quic_jjohnson@quicinc.com> wrote:
>
> (sorry for the 2nd message with no content -- operator error)
