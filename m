Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D4BE4FC3E6
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 20:13:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349091AbiDKSPa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 14:15:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240011AbiDKSP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 14:15:29 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 556DADF95
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 11:13:14 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id k14so14935541pga.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 11:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=Jw2w5fc9s7LYCxNyjF4Anw/31mGnF1Xnlp2YCJojif4=;
        b=zYUmChAbevCzMKAOteYpCt8iCZnXii2/ZAqbsWsSzdO+W6XUiXCDFOfEFJO4LuI29J
         GRfLdTG71rNc/4fdqQ6qUxbUXZRjAg/2nBe3XM+bYVDggr68EsmbxVGph1uscr1XvI7I
         H9thhM8YlDLthSuyIVx3oKcri5EMQCZNH7Nx7iBufxmFnXpJjfMSVZ1CC/4i58B1ZoSZ
         pt68xA/6LSO9ec+sEYg8O1wBSGS4tPWSCfCz0lyB+uncZ0kG0QoNZkTTEmpHD+r/98yR
         ppY5AdTcH52vSTE6T7ECEiu34gSQpmbib1ZrOqRGx9VPczLU12Rjrt+V9ksp8ODe2T0+
         LRjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=Jw2w5fc9s7LYCxNyjF4Anw/31mGnF1Xnlp2YCJojif4=;
        b=zmHeOb2bKJ0KC90igp+GI4HOlnuo8oZqZQn9OMY7oJGxBxmKKrLn1LMsRAbNbIr9vo
         Ygxq1hCQnbdVf7UzZnKkgCubVFJj4nN/mfGVpyoVBKVEtP/B/IYAzp+QEBX/bbA1kjVk
         e37Q8Z9qARhaRMPWmBNAJIxz1ioDHsK/gROhjIH/Vz3pZb8H+0C3s2UEhh2RHAQWHlqt
         iZXE8MXQnf6qJBy9hxaP6LtGXTYwsy9mQmXKmwA95XjPVM3bZFlFP1keOZnBUB2FkId1
         +VIODgNo0SqsVbx6c2nsuYKO7qsan1UkZKM93tYdL3iHJF67/Wj6vnZ2IsAikcYcoPwZ
         xHBQ==
X-Gm-Message-State: AOAM530jApJ2No6JgIIDxLqSrgjWOKDa7uSC8EKx/2YxfkJnzJAU4auk
        2JLsZD6bPJ72Kdu2/CQRDlImQw==
X-Google-Smtp-Source: ABdhPJwFnQOXCSv95jf3Mtp1Xp4D95v+w5pquv+GUaB8VSDncNnmKQidKvtg+7Fpe/4FvzhLFVMuQw==
X-Received: by 2002:a63:6e07:0:b0:398:1337:d99e with SMTP id j7-20020a636e07000000b003981337d99emr27022351pgc.23.1649700793750;
        Mon, 11 Apr 2022 11:13:13 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id x5-20020aa79a45000000b00504a1c8b75asm17752885pfj.165.2022.04.11.11.13.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 11:13:13 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Rex-BC Chen <rex-bc.chen@mediatek.com>, rafael@kernel.org,
        viresh.kumar@linaro.org, robh+dt@kernel.org, krzk+dt@kernel.org
Cc:     matthias.bgg@gmail.com, jia-wei.chang@mediatek.com,
        roger.lu@mediatek.com, hsinyi@google.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH V2 13/15] cpufreq: mediatek: Link CCI device to CPU
In-Reply-To: <bc6dd020a1cc3f00f5be2bf2929046b9116bbeef.camel@mediatek.com>
References: <20220408045908.21671-1-rex-bc.chen@mediatek.com>
 <20220408045908.21671-14-rex-bc.chen@mediatek.com>
 <7hfsmn5m9f.fsf@baylibre.com>
 <bc6dd020a1cc3f00f5be2bf2929046b9116bbeef.camel@mediatek.com>
Date:   Mon, 11 Apr 2022 11:13:12 -0700
Message-ID: <7hwnfv4hfr.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rex-BC Chen <rex-bc.chen@mediatek.com> writes:

> On Fri, 2022-04-08 at 13:54 -0700, Kevin Hilman wrote:
>> Rex-BC Chen <rex-bc.chen@mediatek.com> writes:
>> 
>> > From: Jia-Wei Chang <jia-wei.chang@mediatek.com>
>> > 
>> > In some MediaTek SoCs, like MT8183, CPU and CCI share the same
>> > power
>> > supplies. Cpufreq needs to check if CCI devfreq exists and wait
>> > until
>> > CCI devfreq ready before scaling frequency.
>> > 
>> > - Add is_ccifreq_ready() to link CCI device to CPI, and CPU will
>> > start
>> >   DVFS when CCI is ready.
>> > - Add platform data for MT8183.
>> > 
>> > Signed-off-by: Jia-Wei Chang <jia-wei.chang@mediatek.com>
>> 
>> The checks here are not enough, and will lead to unexpected behavior.
>> IIUC, before doing DVFS, you're checking:
>> 
>> 1) if the "cci" DT node is present and
>> 2) if the driver for that device is bound
>> 
>> If both those conditions are not met, you don't actually fail, you
>> just
>> silently do nothing in ->set_target().  As Angelo pointed out also,
>> this
>> is not a good idea, and will be rather confusing to users.
>> 
>> The same thing would happen if the cci DT node was present, but the
>> CCI
>> devfreq driver was disabled.  Silent failure would also be quite
>> unexpected behavior.  Similarily, if the cci DT node is not present
>> at
>> all (like it is in current upstream DT), this CPUfreq driver will
>> silently do nothing.  Not good.
>> 
>> So, this patch needs to handle several scenarios:
>> 
>> 1) CCI DT node not present
>> 
>> In this case, the driver should still operate normally.  With no CCI
>> node, or driver there's no conflict.
>> 
>> 2) CCI DT present/enabled but not yet bound
>> 
>> In this case, you could return -EAGAIN as suggested by Angelo, or
>> maybe
>> better, it should do a deferred probe.
>> 
>> 3) CCI DT present, but driver disabled
>> 
>> This case is similar to (1), this driver should continue to work.
>> 
>> Kevin
>
> Hello Kevin and Angelo,
>
> In my review, if we do not get the link or the link status is not
> correct between cci and cpufreq in target_index, I think it will never
> established again for this link.
> Because it's not checked in probe stage.
>
> So I think we just need to deal with the issue without cci device, and
> don't expect the link between cci and cpufreq will be connected again.
>
> If I am wrong, please correct me.

I don't fully understand your questions, but I think what your getting
at suggest that you might need to use deferred probe to handle the case
where the ordering of CCI and cpufreq probing is not predictable.

Kevin
