Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88C49525643
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 22:11:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358310AbiELULo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 16:11:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357941AbiELULl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 16:11:41 -0400
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59C065DD00
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 13:11:40 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-ed9a75c453so8002450fac.11
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 13:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=37IX51ckyCTT+yZsWM/kPl+cjpj4hHPN6he08LybAOQ=;
        b=nkDuxOoAbImXZRcvvj1gfFmpDwftHQWbiObrKwOxshF14hW4hHjhBOTZxvvSZQyjLT
         +SNjcd0Eha5XO6P0Rb8nczXCqfhxzo3SDR2fgosVoYMzzq0ezEVJg5i221zzPec69DIX
         cypiO6dAQliJBB0FK5MlRwAOh99s48286unm0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=37IX51ckyCTT+yZsWM/kPl+cjpj4hHPN6he08LybAOQ=;
        b=U8pIyyvW+f5SELn1B8nGBPpNQoYMxi4UxWlNA+renEEwdD9m1qKSmT3vrJYqzrdGX7
         L5HmvdoM4G8SW5ZbKqon/kKK+JTNuTf2ndTPPsWSYfDp45Eqpxep/RCSm8LPjfBe2qi8
         kMQTWV5ZYYoXcLD8vHxhp9MvwZ3uCmPOGgyy9hZjXmVblLDqjUONrV8sryqaFbJyqRIm
         nuaFUrnowswaULI58PgNNmwJFVs2ZA1AE0Psja9QRh1mcDO2TzXvpQJPrJD55YMW9c9X
         in9tN4hML+9O2Shgh8qPxcjKtSWNhpMuixjx+ziPnrOe6jqLWTVhJrdDt0IaC61E6sqR
         zLLA==
X-Gm-Message-State: AOAM531gWI6tJqKNHKTFZWK/N8fakVq5696/HDyP0qLgFVcO+CsRXZco
        fKZnX1WBBIO+SY8fLR8tkdV2XRev9HaYXd5TijYs68lxZc8=
X-Google-Smtp-Source: ABdhPJxd7yZSyV1HL3mHq2/BuEuj5XOOzGUA62h40C+z0kI+RzGTIUcxQQWEo5wiqOsSlg5b3aqgF0K7mnODmWwOJdE=
X-Received: by 2002:a05:6870:40c1:b0:ed:9a12:3f95 with SMTP id
 l1-20020a05687040c100b000ed9a123f95mr831874oal.193.1652386299686; Thu, 12 May
 2022 13:11:39 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 12 May 2022 13:11:39 -0700
MIME-Version: 1.0
In-Reply-To: <CAE-0n50+obQ5qgPNPtUY=OmTgU9bZQ3hNw+MaG9Wi3SQSc-i4A@mail.gmail.com>
References: <20220429233112.2851665-1-swboyd@chromium.org> <20220429233112.2851665-2-swboyd@chromium.org>
 <CAD=FV=VX8EEgkeLgKwyKvjztcjbA8UhKOUpTr-sS1_Ec=QcWbA@mail.gmail.com>
 <CAKdAkRSOtAD6u_cwKhHeMLgz5dC2hfPvVvqmj+17b4i-nspfgg@mail.gmail.com>
 <CAE-0n50Y8tZD9Djn9TVaAiHxehFJ2cZKZ1Z09piDk47uw3nK+Q@mail.gmail.com>
 <Ynzf5jEIECLmELK7@google.com> <CAE-0n50+obQ5qgPNPtUY=OmTgU9bZQ3hNw+MaG9Wi3SQSc-i4A@mail.gmail.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Thu, 12 May 2022 13:11:39 -0700
Message-ID: <CAE-0n52WVNru5fnyaB_7wcBOk4twL0Q92YpRbd40-o6ZBmbXWQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: google,cros-ec-keyb: Introduce
 switches only compatible
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Doug Anderson <dianders@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>, patches@lists.linux.dev,
        chrome-platform@lists.linux.dev,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        "Joseph S. Barrera III" <joebar@chromium.org>
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

Quoting Stephen Boyd (2022-05-12 11:58:02)
> Quoting Dmitry Torokhov (2022-05-12 03:22:30)
> >
> > Have we solved module loading in the presence of multiple compatibles?
> > IIRC we only ever try to load module on the first compatible, so you'd
> > be breaking autoloading cros-ec-keyb on these older kernels. I think the
> > cure that is being proposed is worse than the disease.
> >
>
> The first compatible is still cros-ec-keyb in the driver though? Or you
> mean the first compatible in the node? I'm not aware of this problem at
> all but I can certainly test out a fake node and module and see if it
> gets autoloaded.

I can't get this test module to fail to load no matter what I do. I
commented out the second match table entry, and kept it there and
removed 'vendor,switch-compat' from the DTS. Module still autoloads.

----8<----
diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi
b/arch/arm64/boot/dts/qcom/sc7180.dtsi
index 42a87fa4976e..a6173b79ba67 100644
--- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
@@ -54,6 +54,10 @@ aliases {
 		spi11 = &spi11;
 	};

+	mynode {
+		compatible = "vendor,switch-compat", "vendor,keyb-compat";
+	};
+
 	clocks {
 		xo_board: xo-board {
 			compatible = "fixed-clock";
diff --git a/lib/Makefile b/lib/Makefile
index a841be5244ac..0a784011feb5 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -74,6 +74,7 @@ UBSAN_SANITIZE_test_ubsan.o := y
 obj-$(CONFIG_TEST_KSTRTOX) += test-kstrtox.o
 obj-$(CONFIG_TEST_LIST_SORT) += test_list_sort.o
 obj-$(CONFIG_TEST_MIN_HEAP) += test_min_heap.o
+obj-m += dtmod.o
 obj-$(CONFIG_TEST_LKM) += test_module.o
 obj-$(CONFIG_TEST_VMALLOC) += test_vmalloc.o
 obj-$(CONFIG_TEST_OVERFLOW) += test_overflow.o
diff --git a/lib/dtmod.c b/lib/dtmod.c
new file mode 100644
index 000000000000..c34ae37b8ff0
--- /dev/null
+++ b/lib/dtmod.c
@@ -0,0 +1,44 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/mod_devicetable.h>
+#include <linux/platform_device.h>
+#include <linux/printk.h>
+
+static int test_probe(struct platform_device *pdev)
+{
+	dev_info(&pdev->dev, "I got probed\n");
+
+	return 0;
+}
+
+static int test_remove(struct platform_device *pdev)
+{
+	dev_info(&pdev->dev, "I got removed\n");
+
+	return 0;
+}
+
+static const struct of_device_id test_of_match[] = {
+	{ .compatible = "vendor,keyb-compat" },
+	{ .compatible = "vendor,switch-compat" }, // comment out
+	{}
+};
+MODULE_DEVICE_TABLE(of, test_of_match);
+
+static struct platform_driver test_keyb_driver = {
+	.probe = test_probe,
+	.remove = test_remove,
+	.driver = {
+		.name = "test-ec-keyb",
+		.of_match_table = test_of_match,
+	},
+};
+
+module_platform_driver(test_keyb_driver);
+
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:test-ec-keyb");
