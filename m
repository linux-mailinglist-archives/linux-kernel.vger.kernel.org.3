Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFEA85A82CE
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 18:14:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231836AbiHaQON (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 12:14:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231331AbiHaQOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 12:14:10 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16940CB5F7
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 09:14:09 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id b5so18922173wrr.5
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 09:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=conchuod.ie; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=aMmSguWI98NKmktPvtYnC/l2iKpxumwtwsBe8RwBjGg=;
        b=DH7PvLko7d49IjzAVmtLgrBV49mlxf+9XDXVBbxietelZy/OIaolUAkMFDTBAztNRT
         EMoEQOU27VhuyBJxtL8PFS0vvXB4uSZSv6BZYEtWGxAsrEbvablRpMlaAvFhbZR1UJVs
         EBK0Kjs7TUroqw5S+w092+J24ZCbpfTWwTgi6lQmrCS+UxuHUC3tzTjc/7OjiNjaKzmc
         b4Wu6bVbWaFSFbwV7IV2Zt0M0MZ+C4xrctNpx1T1NFDF57Cv9qIoUu+5kAzmY1a7HfF2
         2dFDdAtZtF3BBHVGpByqhwsHG48GUwgLgN/O2Ybx1zCylPvKfQVYU571NNsWJFZEXaAJ
         14yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=aMmSguWI98NKmktPvtYnC/l2iKpxumwtwsBe8RwBjGg=;
        b=EGhrr2koHNZUxCrlifdGtdmte0DuzmBMuBdCckHcuTd5djfiBWZLwKZw/C/qxTs9QS
         fNN1bI6mpEbWIOi16UiMRpqWBtb+TpqkxLpI3IV3UTf3pXZq8jCcQBoH0OlbIKgMG361
         73c4Zr18aDp5NXoMfLhhj0Nay1EfFkEPc17ri7IvXa0brwQSk8jyNY8OR8/xcShCzNSv
         nRGEfej14Sxh5jP58tlUbKbIWo5sOGr1olv09d/E875wzmafZR1NVydYxvEX5+BN8yZn
         B4NJ+GNT0pzANYVTTyHtf8ueMraBHiyi6MamMYk0FD2YNcH7ZibPZex8iqCcX3OyY94j
         AY7w==
X-Gm-Message-State: ACgBeo1IvenjLQkBk14l4eFW+OgfZlxzmMEuVdJLxiivuLajpO2l05p0
        J++6OPnytwMsZaimmQLulpgFNA==
X-Google-Smtp-Source: AA6agR5Xgtc4NAD3H8V0qmz4NCezn9CoeHu2vc837ligmAydGEGNkQmcnKuj/N0KmvE310P3PNcRVw==
X-Received: by 2002:adf:ce08:0:b0:226:d1ba:3e23 with SMTP id p8-20020adfce08000000b00226d1ba3e23mr11773409wrn.374.1661962447665;
        Wed, 31 Aug 2022 09:14:07 -0700 (PDT)
Received: from henark71.. ([51.37.149.245])
        by smtp.gmail.com with ESMTPSA id w5-20020a5d4b45000000b00226db764fb5sm8269091wrs.47.2022.08.31.09.14.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 09:14:06 -0700 (PDT)
From:   Conor Dooley <mail@conchuod.ie>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Conor Dooley <mail@conchuod.ie>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        Sagar Kadam <sagar.kadam@sifive.com>,
        Atish Patra <atishp@atishpatra.org>,
        devicetree@vger.kernel.org, ben.dooks@sifive.com,
        zong.li@sifive.com
Subject: Re: [PATCH 0/2] Add a PolarFire SoC l2 compatible
Date:   Wed, 31 Aug 2022 17:13:50 +0100
Message-Id: <166196217701.591052.12924322910945691679.b4-ty@microchip.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220825180417.1259360-1-mail@conchuod.ie>
References: <20220825180417.1259360-1-mail@conchuod.ie>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Conor Dooley <conor.dooley@microchip.com>

On Thu, 25 Aug 2022 19:04:16 +0100, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> Whilst re-running checks before sending my dt-fixes PR today I noticed
> that I had introduced another dtbs_check warning by applying one of the
> patches in it.
> 
> PolarFire SoC has 4 cache interrupts, unlike the fu540 (which the dts
> re-uses the compatible of currently) which only has 3. Add a new string
> to the binding like should've been done in the first place...
> 
> [...]

@Palmer, I have applied these to my dt-fixes, branch as the commit they
fix is there too. As I mentioned on IRC, patches for this dt-binding are
usually merged via the riscv tree so I have taken the liberty of bundling
it with the dts change. You may get this in a PR friday morning, but more
likely early next week.

Conor.


[1/2] dt-bindings: riscv: sifive-l2: add a PolarFire SoC compatible
      https://git.kernel.org/conor/c/17e4732d1d8a
[2/2] riscv: dts: microchip: use an mpfs specific l2 compatible
      https://git.kernel.org/conor/c/0dec364ffeb6

Thanks,
Conor.
