Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50571542C42
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 12:00:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235864AbiFHKAC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 06:00:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235491AbiFHJ7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 05:59:43 -0400
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C3635FAA
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 02:33:44 -0700 (PDT)
Received: by mail-pj1-f52.google.com with SMTP id 3-20020a17090a174300b001e426a02ac5so20102687pjm.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 02:33:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=3mAa+qEh4/jfutJ1TxAHiAnCiCxKpOm04PWu4D2bqUk=;
        b=zAcq8NGJBzfMsbWIMzFyjLXEq2wsCtJKn5xettCVuMF3kaLaasP42VYkA/1lXJNNyL
         8eYHgIn7GSaz8AQFRc/k8uhoH1cF/+Wtv5SPpgcT3bKUqsUIPcITDeDztvSeFgpuXjkG
         GMsLUXep2RB/IXwUOj0eDbbwKQlAIo6SQRBqgXyuvs4VELQdfsPh+6EFQsr4vBMNelpt
         NfjzSjMyqDTgfqw1LKVwKcVed4BeE5ehgOeFR/mhrurjtF7RbHEt+1ppP4vbnFv/lJMk
         //wLsD52cPimVVQ7ERRQ0+fBXDBM48VJQN+cyA32YWIQFqEd1q8XZIkf+tNy+0rSpGWe
         7xYg==
X-Gm-Message-State: AOAM5304DrJhM91EJcQ79rraAXyXWlDTjMPrpw1qfMhWjntkJ94f+AZO
        bJhrf5/hQQB8CYOTuluaoV4gtw==
X-Google-Smtp-Source: ABdhPJxBrk9LmLklKuNqznjZxKlkynaLEB3hh2Mbvxl5e4tMEIfkOpur214mjwyKlvI9QsY8cDGQTg==
X-Received: by 2002:a17:902:7087:b0:161:88a4:db37 with SMTP id z7-20020a170902708700b0016188a4db37mr32743936plk.131.1654680823883;
        Wed, 08 Jun 2022 02:33:43 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id o13-20020a170902d4cd00b0015e8d4eb2aesm14318093plg.248.2022.06.08.02.33.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jun 2022 02:33:43 -0700 (PDT)
From:   Kevin Hilman <khilman@kernel.org>
To:     Roger Lu <roger.lu@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Enric Balletbo Serra <eballetbo@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Nicolas Boichat <drinkcat@google.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Fan Chen <fan.chen@mediatek.com>,
        Charles Yang <Charles.Yang@mediatek.com>,
        Angus Lin <Angus.Lin@mediatek.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Nishanth Menon <nm@ti.com>, Roger Lu <roger.lu@mediatek.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Guenter Roeck <linux@roeck-us.net>,
        Jia-wei Chang <jia-wei.chang@mediatek.com>
Subject: Re: [PATCH v25 0/7] soc: mediatek: SVS: introduce MTK SVS
In-Reply-To: <20220516004311.18358-1-roger.lu@mediatek.com>
References: <20220516004311.18358-1-roger.lu@mediatek.com>
Date:   Wed, 08 Jun 2022 02:33:42 -0700
Message-ID: <7ho7z37b49.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Roger Lu <roger.lu@mediatek.com> writes:

> The Smart Voltage Scaling(SVS) engine is a piece of hardware
> which calculates suitable SVS bank voltages to OPP voltage table.
> Then, DVFS driver could apply those SVS bank voltages to PMIC/Buck
> when receiving OPP_EVENT_ADJUST_VOLTAGE.

Tested-by: Kevin Hilman <khilman@baylibre.com>
