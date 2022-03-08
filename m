Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAB2E4D0ED0
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 05:42:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245477AbiCHEmO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 23:42:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245579AbiCHEls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 23:41:48 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 907AA3BA7A
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 20:40:43 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id g19so4763298pfc.9
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 20:40:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=j7+ip+oxWRLl9656rm8jl0V3j8tN7hrFGr/zIiKB03k=;
        b=vYVlbsZ2GNxgUkflM3UI2Yl4zQoI0NjuO+druEsm9oIjrPivL/zZA4KHWJaaCBI9h8
         ymMyi+Tu6ep+HSLTFk4av+DLYG1KlNrEgiqRd/ksI1KTYHtls5+A1jFtxQH6Y4aE1yMV
         +f3jn11ujyDj+MaiGpFe/2ZDTFs0oZ2UyxnUVyWhS4965TWccx55RIPpmDmcAkZrftWi
         +sMwTtnKPtVfuBVMROh7iaBNj9SEZZyYj5UHbw15CMe+mhznitZvfzFN2J5QvY9mtmiu
         MG/jQc9d10ay3b35Yv6OyXpMlfKtdCJJ4YRV92NM6EYklEHHhzk0X2bsOKPco3IdFsZj
         GiUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=j7+ip+oxWRLl9656rm8jl0V3j8tN7hrFGr/zIiKB03k=;
        b=KrivnLCa9rSjzlNCMuT0dqR+9YUpHnnFjZTBuph1F7OQLICmEy7n2kyImpiSSonxFk
         Vh3XuyM3/EAYBjcg6wS6FmQ5amFVN81MSr+BZ4O1rmtgfJCpp9gUT81g8bH1NDfDTztn
         yWsQKalLatZFkNIsuqJvTePNaPoD1e60MEqoSNMG+3gs/d85RCrtvrmj47VzaSqtWY4k
         AxmACLxAR7TgUE/jeiq5W+FLziWc3pOuCVtzOzXzx5j/+lokOf3kFbJIT/WtaShLm58k
         LXVHS0Nltbl6mvbDR8XtGYNkQsDyWBLHJgv78HSvOJhrkvzKCkb2jg7eBmGgXpxg8C4Z
         Ym6Q==
X-Gm-Message-State: AOAM530ulawpmVmL9pUb9I/7TxZPZd/u2RA27E6VZkwjKjLZi4QYi+NQ
        HgIATS2RXFD/hTzkQCxmaj0Twg==
X-Google-Smtp-Source: ABdhPJxmE71kOOa7pwUTgkBKicaxgWByq9zu6dCpOFWEyt2Fx7IFTLvqmQV2Cd013olm2iZcXnU0Tg==
X-Received: by 2002:a62:1a43:0:b0:4f6:ce73:d572 with SMTP id a64-20020a621a43000000b004f6ce73d572mr16545228pfa.69.1646714443061;
        Mon, 07 Mar 2022 20:40:43 -0800 (PST)
Received: from localhost ([223.184.83.228])
        by smtp.gmail.com with ESMTPSA id pc17-20020a17090b3b9100b001bf88fe5edcsm769661pjb.9.2022.03.07.20.40.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 20:40:42 -0800 (PST)
Date:   Tue, 8 Mar 2022 10:10:40 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Tim Chang <jia-wei.chang@mediatek.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, fan.chen@mediatek.com,
        louis.yu@mediatek.com, roger.lu@mediatek.com,
        Allen-yy.Lin@mediatek.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        hsinyi@google.com,
        Jia-Wei Chang <jia-wei.chang@mediatek.corp-partner.google.com>
Subject: Re: [PATCH 3/4] cpufreq: mediatek: clean up cpufreq driver
Message-ID: <20220308044040.6b53fpdaw4fonfui@vireshk-i7>
References: <20220307122151.11666-1-jia-wei.chang@mediatek.com>
 <20220307122151.11666-4-jia-wei.chang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220307122151.11666-4-jia-wei.chang@mediatek.com>
User-Agent: NeoMutt/20180716-391-311a52
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07-03-22, 20:21, Tim Chang wrote:
> cleanup of naming, print log and comments.

As told by Krzysztof, this should be broken into several patches. One
patch for each rename, if you really need to do that.

You shouldn't just change "err" to "ret". It is fine if the driver
used "err" at some places and "ret" at others, but otherwise there is
no need of that change.

This should be easier for us to review, we aren't going to dig into
every minute change here, that you don't describe in the message, and
see if something is wrong. Please make this easier for us.

This patch alone may end up in 5-10 different patches.

-- 
viresh
