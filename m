Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8750455D640
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:16:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240564AbiF0TmD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 15:42:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240527AbiF0Tlo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 15:41:44 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3DD41759E
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 12:41:30 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id e28so9326921wra.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 12:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=conchuod.ie; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7ycV6k4WWkFTlcXLHw72umTHvHWH8LEFc+03pUq4wXA=;
        b=axHtYlAFA802beerF1xUmeKXQb0vB9Fu/ETM67jL15osjDB8WaKiAX7FLhUA8wDNCt
         0JauD+QxMOOSmVweUIMThSA/MdjGiw2P9Zcf7oBC8V470chKbGUhamRKQSN8/JGghVrF
         C8M9VTM8twqOHV5RLITlZzDwSDCwpD0jZhmR72UHeY3tws9Geat9wxnemuqMicTDOuzE
         0fkrc7rybeNJldWOWrgHWcTCto7RUo3nDSkb90H2c9zd3j5W4PmnmKNN62zarK/7bLHX
         capb3ernqGdYqMQ4XmvBWywCw56+3WDEjld2V385oe5lIaCMN8k/EyD0m83ZQXgpwM1Y
         9J/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7ycV6k4WWkFTlcXLHw72umTHvHWH8LEFc+03pUq4wXA=;
        b=bhBRwi3pUHrYmwGxqiEgJ5Vrl5PaczszjO0QOqBX6Rhz/Dtxk41j28BFL4t97Ms5Pw
         5gZOTCN0w4zNgInxjWwkdV306H1iuuuyfZTa0z2ZstrBhSEYp0jBu5pzbV4iBDMjOaz6
         btjEqrusIL21VzLRzeKVDDur3Np2WPln5c3/KQSvzsT/F2yz/4qycqZy5IRHGMpQxWJT
         Q+oZxyoxnYB0ZBZ1wT3gv68VU7XkH7LiffR5zEtSijJQchPt2iVswha2dw/ZvZioipti
         2pQLOFB/6K2H8hq0pds+KEONYKDEeljSLEwlX1rZnUkhZJ/vculi1M936326wsk+Ajpw
         ZgBg==
X-Gm-Message-State: AJIora9dir34xzQ39ELnQMa3VdA59DhOwuF9f2IUkOUNvfv3rcRoHWj5
        LboU7/4AUzegx87vzF7d/6rclg==
X-Google-Smtp-Source: AGRyM1ugZPNhTAyfMNKJfAKWSDZJNQ6t/9bFfe93+HgnOEovCz6LbNAyLlE563FuiIH9qiKlJvd6pA==
X-Received: by 2002:a05:6000:1445:b0:21b:a919:7d3 with SMTP id v5-20020a056000144500b0021ba91907d3mr13498611wrx.545.1656358889211;
        Mon, 27 Jun 2022 12:41:29 -0700 (PDT)
Received: from henark71.. ([51.37.234.167])
        by smtp.gmail.com with ESMTPSA id e9-20020a5d4e89000000b0021a3a87fda9sm11428047wru.47.2022.06.27.12.41.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 12:41:28 -0700 (PDT)
From:   Conor Dooley <mail@conchuod.ie>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Palmer Dabbelt <palmer@rivosinc.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor.dooley@microchip.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Niklas Cassel <niklas.cassel@wdc.com>,
        Dillon Min <dillon.minfei@gmail.com>,
        Heng Sia <jee.heng.sia@intel.com>,
        Jose Abreu <joabreu@synopsys.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-spi@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: [PATCH v2 08/16] riscv: dts: canaan: fix the k210's memory node.
Date:   Mon, 27 Jun 2022 20:39:56 +0100
Message-Id: <20220627194003.2395484-9-mail@conchuod.ie>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220627194003.2395484-1-mail@conchuod.ie>
References: <20220627194003.2395484-1-mail@conchuod.ie>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Conor Dooley <conor.dooley@microchip.com>

The k210 U-Boot port has been using the clocks defined in the
devicetree to bring up the board's SRAM, but this violates the
dt-schema. As such, move the clocks to a dedicated node with
the same compatible string. The regs property does not fit in
either node, so is replaced by comments.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
The corresponding U-Boot code seems to be:
static int sram_init(void)
{
        int ret, i;
        const char * const banks[] = { "sram0", "sram1", "aisram" };
        ofnode memory;
        struct clk clk;

        /* Enable RAM clocks */
        memory = ofnode_by_compatible(ofnode_null(), "canaan,k210-sram");
        if (ofnode_equal(memory, ofnode_null()))
                return -ENOENT;

        for (i = 0; i < ARRAY_SIZE(banks); i++) {
                ret = clk_get_by_name_nodev(memory, banks[i], &clk);
                if (ret)
                        continue;

                ret = clk_enable(&clk);
                clk_free(&clk);
                if (ret)
                        return ret;
        }

        return 0;
}

Which, without having the hardware etc, I suspect is likely to keep
working after the move.
---
 arch/riscv/boot/dts/canaan/k210.dtsi | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/boot/dts/canaan/k210.dtsi b/arch/riscv/boot/dts/canaan/k210.dtsi
index 44d338514761..cd4eae82d8b2 100644
--- a/arch/riscv/boot/dts/canaan/k210.dtsi
+++ b/arch/riscv/boot/dts/canaan/k210.dtsi
@@ -69,11 +69,13 @@ cpu1_intc: interrupt-controller {
 
 	sram: memory@80000000 {
 		device_type = "memory";
+		reg = <0x80000000 0x400000>, /* sram0 4 MiB */
+		      <0x80400000 0x200000>, /* sram1 2 MiB */
+		      <0x80600000 0x200000>; /* aisram 2 MiB */
+	};
+
+	sram_controller: memory-controller {
 		compatible = "canaan,k210-sram";
-		reg = <0x80000000 0x400000>,
-		      <0x80400000 0x200000>,
-		      <0x80600000 0x200000>;
-		reg-names = "sram0", "sram1", "aisram";
 		clocks = <&sysclk K210_CLK_SRAM0>,
 			 <&sysclk K210_CLK_SRAM1>,
 			 <&sysclk K210_CLK_AI>;
-- 
2.36.1

