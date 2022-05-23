Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFACD530B83
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 11:03:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231559AbiEWIC0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 04:02:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231501AbiEWICN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 04:02:13 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D894B16593
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 01:02:08 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1653292927;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=uilnJ10Rc1w03FOogKEf6c8lXTaAE7pNxkXz7xl8CRc=;
        b=YUF2yS2y5EupMLUQsxvAYU6/g3mu9/yLMqSvJLJTAReZjflPYGsOrAoLOmcsy+53oBUzVd
        wYvgjKkf9U/8p93CDhYjjh4Tmbrj/BUdq85QWiwpu6oP2xFZhhXjp1aLvkQ+aw1OJrJCdy
        wXw4hI6b/5YKsjHDjMcQOXp7Kh9PH7MeHHbo+NCM6QkTjDZk678DUKB6dY972orTsAgnRc
        fT6i5WpfKB1cKhQIIzau27f6hoQ3US4aemxbAO9nAM0RANcYhFLnKWD8YaGlEp5r7+zrk7
        1mkB+Fj0LYungsJR5UH4lyiugX84plNFozG8q/B2b3yW0ggAGt1wVuydGHvWWA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1653292927;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=uilnJ10Rc1w03FOogKEf6c8lXTaAE7pNxkXz7xl8CRc=;
        b=0rgoiyKyNcxd3Xf61F24TwRGLTPLzBGEGP8VcJmDxwfdwZG7Dt/fnfl9oDtxtrjaNPms6R
        /R78+iEJlOSfoXCA==
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] irq/core for 5.19-rc1
References: <165329267741.3801280.534077656528571075.tglx@xen13>
Message-ID: <165329268046.3801280.14650675869745686928.tglx@xen13>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Date:   Mon, 23 May 2022 10:02:06 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest irq/core branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-core-2022-05=
-23

up to:  cdb491329389: Merge tag 'irqchip-5.19' of git://git.kernel.org/pub/sc=
m/linux/kernel/git/maz/arm-platforms into irq/core


Updates for interrupt core and drivers:

  Core code:

    - Make the managed interrupts more robust by shutting them down in the
      core code when the assigned affinity mask does not contain online
      CPUs.

    - Make the irq simulator chip work on RT

    - A small set of cpumask and power manageent cleanups

  Drivers:

    - A set of changes which mark GPIO interrupt chips immutable to prevent
      the GPIO subsystem from modifying it under the hood. This provides
      the necessary infrastructure and converts a set of GPIO and pinctrl
      drivers over.

    - A set of changes to make the pseudo-NMI handling for GICv3 more
      robust: a missing barrier and consistent handling of the priority
      mask.

    - Another set of GICv3 improvements and fixes, but nothing outstanding

    - The usual set of improvements and cleanups all over the place

    - No new irqchip drivers and not even a new device tree binding!
      100+ interrupt chips are truly enough.

Thanks,

	tglx

------------------>
Colin Ian King (1):
      genirq/matrix: Remove redundant assignment to variable 'end'

Daniel Thompson (1):
      irqchip/exiu: Fix acknowledgment of edge triggered interrupts

Florian Fainelli (1):
      irqchip/gic: Improved warning about incorrect type

Haowen Bai (1):
      irqchip/csky: Return true/false (not 1/0) from bool functions

Krzysztof Kozlowski (2):
      irqchip/aspeed-i2c-ic: Fix irq_of_parse_and_map() return value
      irqchip/aspeed-scu-ic: Fix irq_of_parse_and_map() return value

Lucas Stach (2):
      irqchip/imx-irqsteer: Constify irq_chip struct
      irqchip/imx-irqsteer: Add runtime PM support

Marc Zyngier (18):
      genirq/msi: Shutdown managed interrupts with unsatifiable affinities
      genirq: Always limit the affinity to online CPUs
      irqchip/gic-v3: Always trust the managed affinity provided by the core =
code
      genirq: Take the proposed affinity at face value if force=3D=3Dtrue
      gpio: Don't fiddle with irqchips marked as immutable
      gpio: Expose the gpiochip_irq_re[ql]res helpers
      gpio: Add helpers to ease the transition towards immutable irq_chip
      gpio: tegra186: Make the irqchip immutable
      gpio: pl061: Make the irqchip immutable
      pinctrl: apple-gpio: Make the irqchip immutable
      pinctrl: msmgpio: Make the irqchip immutable
      pinctrl: amd: Make the irqchip immutable
      gpio: Update TODO to mention immutable irq_chip structures
      Documentation: Update the recommended pattern for GPIO irqchips
      irqchip/gic-v3: Exposes bit values for GICR_CTLR.{IR, CES}
      irqchip/gic-v3: Detect LPI invalidation MMIO registers
      irqchip/gic-v3: Relax polling of GIC{R,D}_CTLR.RWP
      dt-bindings: interrupt-controller: arm,gic-v3: Make the v2 compat requi=
rements explicit

Mark Rutland (3):
      irqchip/gic-v3: Ensure pseudo-NMIs have an ISB between ack and handling
      irqchip/gic-v3: Refactor ISB + EOIR at ack time
      irqchip/gic-v3: Fix priority mask handling

Max Filippov (1):
      irqchip/xtensa-mx: Fix initial IRQ affinity in non-SMP setup

Minghao Chi (1):
      genirq: Use pm_runtime_resume_and_get() instead of pm_runtime_get_sync()

Nathan Rossi (1):
      irqchip/armada-370-xp: Enable MSI affinity configuration

Pali Roh=C3=A1r (1):
      irqchip/armada-370-xp: Do not touch Performance Counter Overflow on A37=
5, A38x, A39x

Robin Murphy (1):
      irqchip/gic-v3: Claim iomem resources

Samuel Holland (2):
      irqchip/sun6i-r: Use NULL for chip_data
      irqchip: Add Kconfig symbols for sunxi drivers

Sebastian Andrzej Siewior (1):
      genirq/irq_sim: Make the irq_work always run in hard irq context

Yury Norov (2):
      genirq/affinity: Replace cpumask_weight() with cpumask_empty() where ap=
propriate
      irqchip/bmips: Replace cpumask_weight() with cpumask_empty()


 .../bindings/interrupt-controller/arm,gic-v3.yaml  |   8 +-
 Documentation/driver-api/gpio/driver.rst           | 175 +++++++++++---
 arch/arm/include/asm/arch_gicv3.h                  |   7 +-
 arch/arm/mach-sunxi/Kconfig                        |  12 +-
 arch/arm64/Kconfig.platforms                       |   6 +-
 arch/arm64/include/asm/arch_gicv3.h                |   6 -
 drivers/gpio/TODO                                  |  19 ++
 drivers/gpio/gpio-pl061.c                          |  32 ++-
 drivers/gpio/gpio-tegra186.c                       |  32 ++-
 drivers/gpio/gpiolib.c                             |  13 +-
 drivers/irqchip/Kconfig                            |  12 +
 drivers/irqchip/Makefile                           |   6 +-
 drivers/irqchip/irq-armada-370-xp.c                |  56 +++--
 drivers/irqchip/irq-aspeed-i2c-ic.c                |   4 +-
 drivers/irqchip/irq-aspeed-scu-ic.c                |   4 +-
 drivers/irqchip/irq-bcm6345-l1.c                   |   2 +-
 drivers/irqchip/irq-csky-apb-intc.c                |   4 +-
 drivers/irqchip/irq-gic-v3-its.c                   |   2 +-
 drivers/irqchip/irq-gic-v3.c                       | 256 +++++++++++++------=
--
 drivers/irqchip/irq-gic.c                          |   6 +-
 drivers/irqchip/irq-imx-irqsteer.c                 |  16 +-
 drivers/irqchip/irq-sni-exiu.c                     |  25 +-
 drivers/irqchip/irq-sun6i-r.c                      |   6 +-
 drivers/irqchip/irq-xtensa-mx.c                    |  18 +-
 drivers/pinctrl/pinctrl-amd.c                      |  11 +-
 drivers/pinctrl/pinctrl-apple-gpio.c               |  29 +--
 drivers/pinctrl/qcom/pinctrl-msm.c                 |  53 +++--
 include/linux/gpio/driver.h                        |  16 ++
 include/linux/irq.h                                |   2 +
 include/linux/irqchip/arm-gic-v3.h                 |   2 +
 kernel/irq/affinity.c                              |   2 +-
 kernel/irq/chip.c                                  |  13 +-
 kernel/irq/debugfs.c                               |   1 +
 kernel/irq/irq_sim.c                               |   2 +-
 kernel/irq/manage.c                                |  31 ++-
 kernel/irq/matrix.c                                |   2 +-
 kernel/irq/msi.c                                   |  15 ++
 37 files changed, 644 insertions(+), 262 deletions(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v=
3.yaml b/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.ya=
ml
index b7197f78e158..3912a89162f0 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.yaml
@@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: ARM Generic Interrupt Controller, version 3
=20
 maintainers:
-  - Marc Zyngier <marc.zyngier@arm.com>
+  - Marc Zyngier <maz@kernel.org>
=20
 description: |
   AArch64 SMP cores are often associated with a GICv3, providing Private
@@ -78,7 +78,11 @@ properties:
       - GIC Hypervisor interface (GICH)
       - GIC Virtual CPU interface (GICV)
=20
-      GICC, GICH and GICV are optional.
+      GICC, GICH and GICV are optional, but must be described if the CPUs
+      support them. Examples of such CPUs are ARM's implementations of the
+      ARMv8.0 architecture such as Cortex-A32, A34, A35, A53, A57, A72 and
+      A73 (this list is not exhaustive).
+
     minItems: 2
     maxItems: 4096   # Should be enough?
=20
diff --git a/Documentation/driver-api/gpio/driver.rst b/Documentation/driver-=
api/gpio/driver.rst
index bbc53920d4dd..a1ddefa1f55f 100644
--- a/Documentation/driver-api/gpio/driver.rst
+++ b/Documentation/driver-api/gpio/driver.rst
@@ -417,30 +417,66 @@ struct gpio_irq_chip inside struct gpio_chip before add=
ing the gpio_chip.
 If you do this, the additional irq_chip will be set up by gpiolib at the
 same time as setting up the rest of the GPIO functionality. The following
 is a typical example of a chained cascaded interrupt handler using
-the gpio_irq_chip:
+the gpio_irq_chip. Note how the mask/unmask (or disable/enable) functions
+call into the core gpiolib code:
=20
 .. code-block:: c
=20
-  /* Typical state container with dynamic irqchip */
+  /* Typical state container */
   struct my_gpio {
       struct gpio_chip gc;
-      struct irq_chip irq;
+  };
+
+  static void my_gpio_mask_irq(struct irq_data *d)
+  {
+      struct gpio_chip *gc =3D irq_desc_get_handler_data(d);
+
+      /*
+       * Perform any necessary action to mask the interrupt,
+       * and then call into the core code to synchronise the
+       * state.
+       */
+
+      gpiochip_disable_irq(gc, d->hwirq);
+  }
+
+  static void my_gpio_unmask_irq(struct irq_data *d)
+  {
+      struct gpio_chip *gc =3D irq_desc_get_handler_data(d);
+
+      gpiochip_enable_irq(gc, d->hwirq);
+
+      /*
+       * Perform any necessary action to unmask the interrupt,
+       * after having called into the core code to synchronise
+       * the state.
+       */
+  }
+
+  /*
+   * Statically populate the irqchip. Note that it is made const
+   * (further indicated by the IRQCHIP_IMMUTABLE flag), and that
+   * the GPIOCHIP_IRQ_RESOURCE_HELPER macro adds some extra
+   * callbacks to the structure.
+   */
+  static const struct irq_chip my_gpio_irq_chip =3D {
+      .name		=3D "my_gpio_irq",
+      .irq_ack		=3D my_gpio_ack_irq,
+      .irq_mask		=3D my_gpio_mask_irq,
+      .irq_unmask	=3D my_gpio_unmask_irq,
+      .irq_set_type	=3D my_gpio_set_irq_type,
+      .flags		=3D IRQCHIP_IMMUTABLE,
+      /* Provide the gpio resource callbacks */
+      GPIOCHIP_IRQ_RESOURCE_HELPERS,
   };
=20
   int irq; /* from platform etc */
   struct my_gpio *g;
   struct gpio_irq_chip *girq;
=20
-  /* Set up the irqchip dynamically */
-  g->irq.name =3D "my_gpio_irq";
-  g->irq.irq_ack =3D my_gpio_ack_irq;
-  g->irq.irq_mask =3D my_gpio_mask_irq;
-  g->irq.irq_unmask =3D my_gpio_unmask_irq;
-  g->irq.irq_set_type =3D my_gpio_set_irq_type;
-
   /* Get a pointer to the gpio_irq_chip */
   girq =3D &g->gc.irq;
-  girq->chip =3D &g->irq;
+  gpio_irq_chip_set_chip(girq, &my_gpio_irq_chip);
   girq->parent_handler =3D ftgpio_gpio_irq_handler;
   girq->num_parents =3D 1;
   girq->parents =3D devm_kcalloc(dev, 1, sizeof(*girq->parents),
@@ -458,23 +494,58 @@ the interrupt separately and go with it:
=20
 .. code-block:: c
=20
-  /* Typical state container with dynamic irqchip */
+  /* Typical state container */
   struct my_gpio {
       struct gpio_chip gc;
-      struct irq_chip irq;
+  };
+
+  static void my_gpio_mask_irq(struct irq_data *d)
+  {
+      struct gpio_chip *gc =3D irq_desc_get_handler_data(d);
+
+      /*
+       * Perform any necessary action to mask the interrupt,
+       * and then call into the core code to synchronise the
+       * state.
+       */
+
+      gpiochip_disable_irq(gc, d->hwirq);
+  }
+
+  static void my_gpio_unmask_irq(struct irq_data *d)
+  {
+      struct gpio_chip *gc =3D irq_desc_get_handler_data(d);
+
+      gpiochip_enable_irq(gc, d->hwirq);
+
+      /*
+       * Perform any necessary action to unmask the interrupt,
+       * after having called into the core code to synchronise
+       * the state.
+       */
+  }
+
+  /*
+   * Statically populate the irqchip. Note that it is made const
+   * (further indicated by the IRQCHIP_IMMUTABLE flag), and that
+   * the GPIOCHIP_IRQ_RESOURCE_HELPER macro adds some extra
+   * callbacks to the structure.
+   */
+  static const struct irq_chip my_gpio_irq_chip =3D {
+      .name		=3D "my_gpio_irq",
+      .irq_ack		=3D my_gpio_ack_irq,
+      .irq_mask		=3D my_gpio_mask_irq,
+      .irq_unmask	=3D my_gpio_unmask_irq,
+      .irq_set_type	=3D my_gpio_set_irq_type,
+      .flags		=3D IRQCHIP_IMMUTABLE,
+      /* Provide the gpio resource callbacks */
+      GPIOCHIP_IRQ_RESOURCE_HELPERS,
   };
=20
   int irq; /* from platform etc */
   struct my_gpio *g;
   struct gpio_irq_chip *girq;
=20
-  /* Set up the irqchip dynamically */
-  g->irq.name =3D "my_gpio_irq";
-  g->irq.irq_ack =3D my_gpio_ack_irq;
-  g->irq.irq_mask =3D my_gpio_mask_irq;
-  g->irq.irq_unmask =3D my_gpio_unmask_irq;
-  g->irq.irq_set_type =3D my_gpio_set_irq_type;
-
   ret =3D devm_request_threaded_irq(dev, irq, NULL,
 		irq_thread_fn, IRQF_ONESHOT, "my-chip", g);
   if (ret < 0)
@@ -482,7 +553,7 @@ the interrupt separately and go with it:
=20
   /* Get a pointer to the gpio_irq_chip */
   girq =3D &g->gc.irq;
-  girq->chip =3D &g->irq;
+  gpio_irq_chip_set_chip(girq, &my_gpio_irq_chip);
   /* This will let us handle the parent IRQ in the driver */
   girq->parent_handler =3D NULL;
   girq->num_parents =3D 0;
@@ -500,24 +571,61 @@ In this case the typical set-up will look like this:
   /* Typical state container with dynamic irqchip */
   struct my_gpio {
       struct gpio_chip gc;
-      struct irq_chip irq;
       struct fwnode_handle *fwnode;
   };
=20
-  int irq; /* from platform etc */
+  static void my_gpio_mask_irq(struct irq_data *d)
+  {
+      struct gpio_chip *gc =3D irq_desc_get_handler_data(d);
+
+      /*
+       * Perform any necessary action to mask the interrupt,
+       * and then call into the core code to synchronise the
+       * state.
+       */
+
+      gpiochip_disable_irq(gc, d->hwirq);
+      irq_mask_mask_parent(d);
+  }
+
+  static void my_gpio_unmask_irq(struct irq_data *d)
+  {
+      struct gpio_chip *gc =3D irq_desc_get_handler_data(d);
+
+      gpiochip_enable_irq(gc, d->hwirq);
+
+      /*
+       * Perform any necessary action to unmask the interrupt,
+       * after having called into the core code to synchronise
+       * the state.
+       */
+
+      irq_mask_unmask_parent(d);
+  }
+
+  /*
+   * Statically populate the irqchip. Note that it is made const
+   * (further indicated by the IRQCHIP_IMMUTABLE flag), and that
+   * the GPIOCHIP_IRQ_RESOURCE_HELPER macro adds some extra
+   * callbacks to the structure.
+   */
+  static const struct irq_chip my_gpio_irq_chip =3D {
+      .name		=3D "my_gpio_irq",
+      .irq_ack		=3D my_gpio_ack_irq,
+      .irq_mask		=3D my_gpio_mask_irq,
+      .irq_unmask	=3D my_gpio_unmask_irq,
+      .irq_set_type	=3D my_gpio_set_irq_type,
+      .flags		=3D IRQCHIP_IMMUTABLE,
+      /* Provide the gpio resource callbacks */
+      GPIOCHIP_IRQ_RESOURCE_HELPERS,
+  };
+
   struct my_gpio *g;
   struct gpio_irq_chip *girq;
=20
-  /* Set up the irqchip dynamically */
-  g->irq.name =3D "my_gpio_irq";
-  g->irq.irq_ack =3D my_gpio_ack_irq;
-  g->irq.irq_mask =3D my_gpio_mask_irq;
-  g->irq.irq_unmask =3D my_gpio_unmask_irq;
-  g->irq.irq_set_type =3D my_gpio_set_irq_type;
-
   /* Get a pointer to the gpio_irq_chip */
   girq =3D &g->gc.irq;
-  girq->chip =3D &g->irq;
+  gpio_irq_chip_set_chip(girq, &my_gpio_irq_chip);
   girq->default_type =3D IRQ_TYPE_NONE;
   girq->handler =3D handle_bad_irq;
   girq->fwnode =3D g->fwnode;
@@ -605,8 +713,9 @@ When implementing an irqchip inside a GPIO driver, these =
two functions should
 typically be called in the .irq_disable() and .irq_enable() callbacks from t=
he
 irqchip.
=20
-When using the gpiolib irqchip helpers, these callbacks are automatically
-assigned.
+When IRQCHIP_IMMUTABLE is not advertised by the irqchip, these callbacks
+are automatically assigned. This behaviour is deprecated and on its way
+to be removed from the kernel.
=20
=20
 Real-Time compliance for GPIO IRQ chips
diff --git a/arch/arm/include/asm/arch_gicv3.h b/arch/arm/include/asm/arch_gi=
cv3.h
index 413abfb42989..f82a819eb0db 100644
--- a/arch/arm/include/asm/arch_gicv3.h
+++ b/arch/arm/include/asm/arch_gicv3.h
@@ -48,6 +48,7 @@ static inline u32 read_ ## a64(void)		\
 	return read_sysreg(a32); 		\
 }						\
=20
+CPUIF_MAP(ICC_EOIR1, ICC_EOIR1_EL1)
 CPUIF_MAP(ICC_PMR, ICC_PMR_EL1)
 CPUIF_MAP(ICC_AP0R0, ICC_AP0R0_EL1)
 CPUIF_MAP(ICC_AP0R1, ICC_AP0R1_EL1)
@@ -63,12 +64,6 @@ CPUIF_MAP(ICC_AP1R3, ICC_AP1R3_EL1)
=20
 /* Low-level accessors */
=20
-static inline void gic_write_eoir(u32 irq)
-{
-	write_sysreg(irq, ICC_EOIR1);
-	isb();
-}
-
 static inline void gic_write_dir(u32 val)
 {
 	write_sysreg(val, ICC_DIR);
diff --git a/arch/arm/mach-sunxi/Kconfig b/arch/arm/mach-sunxi/Kconfig
index e5c2fce281cd..abdb99fe1e97 100644
--- a/arch/arm/mach-sunxi/Kconfig
+++ b/arch/arm/mach-sunxi/Kconfig
@@ -4,10 +4,7 @@ menuconfig ARCH_SUNXI
 	depends on ARCH_MULTI_V5 || ARCH_MULTI_V7
 	select ARCH_HAS_RESET_CONTROLLER
 	select CLKSRC_MMIO
-	select GENERIC_IRQ_CHIP
 	select GPIOLIB
-	select IRQ_DOMAIN_HIERARCHY
-	select IRQ_FASTEOI_HIERARCHY_HANDLERS
 	select PINCTRL
 	select PM_OPP
 	select SUN4I_TIMER
@@ -22,10 +19,12 @@ if ARCH_MULTI_V7
 config MACH_SUN4I
 	bool "Allwinner A10 (sun4i) SoCs support"
 	default ARCH_SUNXI
+	select SUN4I_INTC
=20
 config MACH_SUN5I
 	bool "Allwinner A10s / A13 (sun5i) SoCs support"
 	default ARCH_SUNXI
+	select SUN4I_INTC
 	select SUN5I_HSTIMER
=20
 config MACH_SUN6I
@@ -34,6 +33,8 @@ config MACH_SUN6I
 	select ARM_GIC
 	select MFD_SUN6I_PRCM
 	select SUN5I_HSTIMER
+	select SUN6I_R_INTC
+	select SUNXI_NMI_INTC
=20
 config MACH_SUN7I
 	bool "Allwinner A20 (sun7i) SoCs support"
@@ -43,17 +44,21 @@ config MACH_SUN7I
 	select ARCH_SUPPORTS_BIG_ENDIAN
 	select HAVE_ARM_ARCH_TIMER
 	select SUN5I_HSTIMER
+	select SUNXI_NMI_INTC
=20
 config MACH_SUN8I
 	bool "Allwinner sun8i Family SoCs support"
 	default ARCH_SUNXI
 	select ARM_GIC
 	select MFD_SUN6I_PRCM
+	select SUN6I_R_INTC
+	select SUNXI_NMI_INTC
=20
 config MACH_SUN9I
 	bool "Allwinner (sun9i) SoCs support"
 	default ARCH_SUNXI
 	select ARM_GIC
+	select SUNXI_NMI_INTC
=20
 config ARCH_SUNXI_MC_SMP
 	bool
@@ -69,6 +74,7 @@ if ARCH_MULTI_V5
 config MACH_SUNIV
 	bool "Allwinner ARMv5 F-series (suniv) SoCs support"
 	default ARCH_SUNXI
+	select SUN4I_INTC
 	help
 	  Support for Allwinner suniv ARMv5 SoCs.
 	  (F1C100A, F1C100s, F1C200s, F1C500, F1C600)
diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 30b123cde02c..6a6457fed7b2 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -11,12 +11,11 @@ config ARCH_ACTIONS
 config ARCH_SUNXI
 	bool "Allwinner sunxi 64-bit SoC Family"
 	select ARCH_HAS_RESET_CONTROLLER
-	select GENERIC_IRQ_CHIP
-	select IRQ_DOMAIN_HIERARCHY
-	select IRQ_FASTEOI_HIERARCHY_HANDLERS
 	select PINCTRL
 	select RESET_CONTROLLER
 	select SUN4I_TIMER
+	select SUN6I_R_INTC
+	select SUNXI_NMI_INTC
 	help
 	  This enables support for Allwinner sunxi based SoCs like the A64.
=20
@@ -253,6 +252,7 @@ config ARCH_INTEL_SOCFPGA
=20
 config ARCH_SYNQUACER
 	bool "Socionext SynQuacer SoC Family"
+	select IRQ_FASTEOI_HIERARCHY_HANDLERS
=20
 config ARCH_TEGRA
 	bool "NVIDIA Tegra SoC Family"
diff --git a/arch/arm64/include/asm/arch_gicv3.h b/arch/arm64/include/asm/arc=
h_gicv3.h
index 8bd5afc7b692..48d4473e8eee 100644
--- a/arch/arm64/include/asm/arch_gicv3.h
+++ b/arch/arm64/include/asm/arch_gicv3.h
@@ -26,12 +26,6 @@
  * sets the GP register's most significant bits to 0 with an explicit cast.
  */
=20
-static inline void gic_write_eoir(u32 irq)
-{
-	write_sysreg_s(irq, SYS_ICC_EOIR1_EL1);
-	isb();
-}
-
 static __always_inline void gic_write_dir(u32 irq)
 {
 	write_sysreg_s(irq, SYS_ICC_DIR_EL1);
diff --git a/drivers/gpio/TODO b/drivers/gpio/TODO
index b8b1473a5b1e..f87ff3fa8a53 100644
--- a/drivers/gpio/TODO
+++ b/drivers/gpio/TODO
@@ -178,3 +178,22 @@ discussed but the idea is to provide a low-level access =
point
 for debugging and hacking and to expose all lines without the
 need of any exporting. Also provide ample ammunition to shoot
 oneself in the foot, because this is debugfs after all.
+
+
+Moving over to immutable irq_chip structures
+
+Most of the gpio chips implementing interrupt support rely on gpiolib
+intercepting some of the irq_chip callbacks, preventing the structures
+from being made read-only and forcing duplication of structures that
+should otherwise be unique.
+
+The solution is to call into the gpiolib code when needed (resource
+management, enable/disable or unmask/mask callbacks), and to let the
+core code know about that by exposing a flag (IRQCHIP_IMMUTABLE) in
+the irq_chip structure. The irq_chip structure can then be made unique
+and const.
+
+A small number of drivers have been converted (pl061, tegra186, msm,
+amd, apple), and can be used as examples of how to proceed with this
+conversion. Note that drivers using the generic irqchip framework
+cannot be converted yet, but watch this space!
diff --git a/drivers/gpio/gpio-pl061.c b/drivers/gpio/gpio-pl061.c
index 4ecab700f23f..6464056cb6ae 100644
--- a/drivers/gpio/gpio-pl061.c
+++ b/drivers/gpio/gpio-pl061.c
@@ -52,7 +52,6 @@ struct pl061 {
=20
 	void __iomem		*base;
 	struct gpio_chip	gc;
-	struct irq_chip		irq_chip;
 	int			parent_irq;
=20
 #ifdef CONFIG_PM
@@ -241,6 +240,8 @@ static void pl061_irq_mask(struct irq_data *d)
 	gpioie =3D readb(pl061->base + GPIOIE) & ~mask;
 	writeb(gpioie, pl061->base + GPIOIE);
 	raw_spin_unlock(&pl061->lock);
+
+	gpiochip_disable_irq(gc, d->hwirq);
 }
=20
 static void pl061_irq_unmask(struct irq_data *d)
@@ -250,6 +251,8 @@ static void pl061_irq_unmask(struct irq_data *d)
 	u8 mask =3D BIT(irqd_to_hwirq(d) % PL061_GPIO_NR);
 	u8 gpioie;
=20
+	gpiochip_enable_irq(gc, d->hwirq);
+
 	raw_spin_lock(&pl061->lock);
 	gpioie =3D readb(pl061->base + GPIOIE) | mask;
 	writeb(gpioie, pl061->base + GPIOIE);
@@ -283,6 +286,24 @@ static int pl061_irq_set_wake(struct irq_data *d, unsign=
ed int state)
 	return irq_set_irq_wake(pl061->parent_irq, state);
 }
=20
+static void pl061_irq_print_chip(struct irq_data *data, struct seq_file *p)
+{
+	struct gpio_chip *gc =3D irq_data_get_irq_chip_data(data);
+
+	seq_printf(p, dev_name(gc->parent));
+}
+
+static const struct irq_chip pl061_irq_chip =3D {
+	.irq_ack		=3D pl061_irq_ack,
+	.irq_mask		=3D pl061_irq_mask,
+	.irq_unmask		=3D pl061_irq_unmask,
+	.irq_set_type		=3D pl061_irq_type,
+	.irq_set_wake		=3D pl061_irq_set_wake,
+	.irq_print_chip		=3D pl061_irq_print_chip,
+	.flags			=3D IRQCHIP_IMMUTABLE,
+	GPIOCHIP_IRQ_RESOURCE_HELPERS,
+};
+
 static int pl061_probe(struct amba_device *adev, const struct amba_id *id)
 {
 	struct device *dev =3D &adev->dev;
@@ -315,13 +336,6 @@ static int pl061_probe(struct amba_device *adev, const s=
truct amba_id *id)
 	/*
 	 * irq_chip support
 	 */
-	pl061->irq_chip.name =3D dev_name(dev);
-	pl061->irq_chip.irq_ack	=3D pl061_irq_ack;
-	pl061->irq_chip.irq_mask =3D pl061_irq_mask;
-	pl061->irq_chip.irq_unmask =3D pl061_irq_unmask;
-	pl061->irq_chip.irq_set_type =3D pl061_irq_type;
-	pl061->irq_chip.irq_set_wake =3D pl061_irq_set_wake;
-
 	writeb(0, pl061->base + GPIOIE); /* disable irqs */
 	irq =3D adev->irq[0];
 	if (!irq)
@@ -329,7 +343,7 @@ static int pl061_probe(struct amba_device *adev, const st=
ruct amba_id *id)
 	pl061->parent_irq =3D irq;
=20
 	girq =3D &pl061->gc.irq;
-	girq->chip =3D &pl061->irq_chip;
+	gpio_irq_chip_set_chip(girq, &pl061_irq_chip);
 	girq->parent_handler =3D pl061_irq_handler;
 	girq->num_parents =3D 1;
 	girq->parents =3D devm_kcalloc(dev, 1, sizeof(*girq->parents),
diff --git a/drivers/gpio/gpio-tegra186.c b/drivers/gpio/gpio-tegra186.c
index 031fe105b58e..84c4f1e9fb0c 100644
--- a/drivers/gpio/gpio-tegra186.c
+++ b/drivers/gpio/gpio-tegra186.c
@@ -80,7 +80,6 @@ struct tegra_gpio_soc {
=20
 struct tegra_gpio {
 	struct gpio_chip gpio;
-	struct irq_chip intc;
 	unsigned int num_irq;
 	unsigned int *irq;
=20
@@ -372,6 +371,8 @@ static void tegra186_irq_mask(struct irq_data *data)
 	value =3D readl(base + TEGRA186_GPIO_ENABLE_CONFIG);
 	value &=3D ~TEGRA186_GPIO_ENABLE_CONFIG_INTERRUPT;
 	writel(value, base + TEGRA186_GPIO_ENABLE_CONFIG);
+
+	gpiochip_disable_irq(&gpio->gpio, data->hwirq);
 }
=20
 static void tegra186_irq_unmask(struct irq_data *data)
@@ -385,6 +386,8 @@ static void tegra186_irq_unmask(struct irq_data *data)
 	if (WARN_ON(base =3D=3D NULL))
 		return;
=20
+	gpiochip_enable_irq(&gpio->gpio, data->hwirq);
+
 	value =3D readl(base + TEGRA186_GPIO_ENABLE_CONFIG);
 	value |=3D TEGRA186_GPIO_ENABLE_CONFIG_INTERRUPT;
 	writel(value, base + TEGRA186_GPIO_ENABLE_CONFIG);
@@ -456,6 +459,24 @@ static int tegra186_irq_set_wake(struct irq_data *data, =
unsigned int on)
 	return 0;
 }
=20
+static void tegra186_irq_print_chip(struct irq_data *data, struct seq_file *=
p)
+{
+	struct gpio_chip *gc =3D irq_data_get_irq_chip_data(data);
+
+	seq_printf(p, dev_name(gc->parent));
+}
+
+static const struct irq_chip tegra186_gpio_irq_chip =3D {
+	.irq_ack		=3D tegra186_irq_ack,
+	.irq_mask		=3D tegra186_irq_mask,
+	.irq_unmask		=3D tegra186_irq_unmask,
+	.irq_set_type		=3D tegra186_irq_set_type,
+	.irq_set_wake		=3D tegra186_irq_set_wake,
+	.irq_print_chip		=3D tegra186_irq_print_chip,
+	.flags			=3D IRQCHIP_IMMUTABLE,
+	GPIOCHIP_IRQ_RESOURCE_HELPERS,
+};
+
 static void tegra186_gpio_irq(struct irq_desc *desc)
 {
 	struct tegra_gpio *gpio =3D irq_desc_get_handler_data(desc);
@@ -760,15 +781,8 @@ static int tegra186_gpio_probe(struct platform_device *p=
dev)
 	gpio->gpio.of_xlate =3D tegra186_gpio_of_xlate;
 #endif /* CONFIG_OF_GPIO */
=20
-	gpio->intc.name =3D dev_name(&pdev->dev);
-	gpio->intc.irq_ack =3D tegra186_irq_ack;
-	gpio->intc.irq_mask =3D tegra186_irq_mask;
-	gpio->intc.irq_unmask =3D tegra186_irq_unmask;
-	gpio->intc.irq_set_type =3D tegra186_irq_set_type;
-	gpio->intc.irq_set_wake =3D tegra186_irq_set_wake;
-
 	irq =3D &gpio->gpio.irq;
-	irq->chip =3D &gpio->intc;
+	gpio_irq_chip_set_chip(irq, &tegra186_gpio_irq_chip);
 	irq->fwnode =3D of_node_to_fwnode(pdev->dev.of_node);
 	irq->child_to_parent_hwirq =3D tegra186_gpio_child_to_parent_hwirq;
 	irq->populate_parent_alloc_arg =3D tegra186_gpio_populate_parent_fwspec;
diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 085348e08986..c813a6adbb6e 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -1433,19 +1433,21 @@ static int gpiochip_to_irq(struct gpio_chip *gc, unsi=
gned int offset)
 	return irq_create_mapping(domain, offset);
 }
=20
-static int gpiochip_irq_reqres(struct irq_data *d)
+int gpiochip_irq_reqres(struct irq_data *d)
 {
 	struct gpio_chip *gc =3D irq_data_get_irq_chip_data(d);
=20
 	return gpiochip_reqres_irq(gc, d->hwirq);
 }
+EXPORT_SYMBOL(gpiochip_irq_reqres);
=20
-static void gpiochip_irq_relres(struct irq_data *d)
+void gpiochip_irq_relres(struct irq_data *d)
 {
 	struct gpio_chip *gc =3D irq_data_get_irq_chip_data(d);
=20
 	gpiochip_relres_irq(gc, d->hwirq);
 }
+EXPORT_SYMBOL(gpiochip_irq_relres);
=20
 static void gpiochip_irq_mask(struct irq_data *d)
 {
@@ -1485,6 +1487,11 @@ static void gpiochip_set_irq_hooks(struct gpio_chip *g=
c)
 {
 	struct irq_chip *irqchip =3D gc->irq.chip;
=20
+	if (irqchip->flags & IRQCHIP_IMMUTABLE)
+		return;
+
+	chip_warn(gc, "not an immutable chip, please consider fixing it!\n");
+
 	if (!irqchip->irq_request_resources &&
 	    !irqchip->irq_release_resources) {
 		irqchip->irq_request_resources =3D gpiochip_irq_reqres;
@@ -1652,7 +1659,7 @@ static void gpiochip_irqchip_remove(struct gpio_chip *g=
c)
 		irq_domain_remove(gc->irq.domain);
 	}
=20
-	if (irqchip) {
+	if (irqchip && !(irqchip->flags & IRQCHIP_IMMUTABLE)) {
 		if (irqchip->irq_request_resources =3D=3D gpiochip_irq_reqres) {
 			irqchip->irq_request_resources =3D NULL;
 			irqchip->irq_release_resources =3D NULL;
diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 15edb9a6fcae..135c156673a7 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -257,6 +257,18 @@ config ST_IRQCHIP
 	help
 	  Enables SysCfg Controlled IRQs on STi based platforms.
=20
+config SUN4I_INTC
+	bool
+
+config SUN6I_R_INTC
+	bool
+	select IRQ_DOMAIN_HIERARCHY
+	select IRQ_FASTEOI_HIERARCHY_HANDLERS
+
+config SUNXI_NMI_INTC
+	bool
+	select GENERIC_IRQ_CHIP
+
 config TB10X_IRQC
 	bool
 	select IRQ_DOMAIN
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index 160a1d8ceaa9..9b1ffb0f98cc 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -23,9 +23,9 @@ obj-$(CONFIG_OMPIC)			+=3D irq-ompic.o
 obj-$(CONFIG_OR1K_PIC)			+=3D irq-or1k-pic.o
 obj-$(CONFIG_ORION_IRQCHIP)		+=3D irq-orion.o
 obj-$(CONFIG_OMAP_IRQCHIP)		+=3D irq-omap-intc.o
-obj-$(CONFIG_ARCH_SUNXI)		+=3D irq-sun4i.o
-obj-$(CONFIG_ARCH_SUNXI)		+=3D irq-sun6i-r.o
-obj-$(CONFIG_ARCH_SUNXI)		+=3D irq-sunxi-nmi.o
+obj-$(CONFIG_SUN4I_INTC)		+=3D irq-sun4i.o
+obj-$(CONFIG_SUN6I_R_INTC)		+=3D irq-sun6i-r.o
+obj-$(CONFIG_SUNXI_NMI_INTC)		+=3D irq-sunxi-nmi.o
 obj-$(CONFIG_ARCH_SPEAR3XX)		+=3D spear-shirq.o
 obj-$(CONFIG_ARM_GIC)			+=3D irq-gic.o irq-gic-common.o
 obj-$(CONFIG_ARM_GIC_PM)		+=3D irq-gic-pm.o
diff --git a/drivers/irqchip/irq-armada-370-xp.c b/drivers/irqchip/irq-armada=
-370-xp.c
index 5b8d571c041d..ee18eb3e72b7 100644
--- a/drivers/irqchip/irq-armada-370-xp.c
+++ b/drivers/irqchip/irq-armada-370-xp.c
@@ -209,15 +209,29 @@ static struct msi_domain_info armada_370_xp_msi_domain_=
info =3D {
=20
 static void armada_370_xp_compose_msi_msg(struct irq_data *data, struct msi_=
msg *msg)
 {
+	unsigned int cpu =3D cpumask_first(irq_data_get_effective_affinity_mask(dat=
a));
+
 	msg->address_lo =3D lower_32_bits(msi_doorbell_addr);
 	msg->address_hi =3D upper_32_bits(msi_doorbell_addr);
-	msg->data =3D 0xf00 | (data->hwirq + PCI_MSI_DOORBELL_START);
+	msg->data =3D BIT(cpu + 8) | (data->hwirq + PCI_MSI_DOORBELL_START);
 }
=20
 static int armada_370_xp_msi_set_affinity(struct irq_data *irq_data,
 					  const struct cpumask *mask, bool force)
 {
-	 return -EINVAL;
+	unsigned int cpu;
+
+	if (!force)
+		cpu =3D cpumask_any_and(mask, cpu_online_mask);
+	else
+		cpu =3D cpumask_first(mask);
+
+	if (cpu >=3D nr_cpu_ids)
+		return -EINVAL;
+
+	irq_data_update_effective_affinity(irq_data, cpumask_of(cpu));
+
+	return IRQ_SET_MASK_OK;
 }
=20
 static struct irq_chip armada_370_xp_msi_bottom_irq_chip =3D {
@@ -264,11 +278,21 @@ static const struct irq_domain_ops armada_370_xp_msi_do=
main_ops =3D {
 	.free	=3D armada_370_xp_msi_free,
 };
=20
-static int armada_370_xp_msi_init(struct device_node *node,
-				  phys_addr_t main_int_phys_base)
+static void armada_370_xp_msi_reenable_percpu(void)
 {
 	u32 reg;
=20
+	/* Enable MSI doorbell mask and combined cpu local interrupt */
+	reg =3D readl(per_cpu_int_base + ARMADA_370_XP_IN_DRBEL_MSK_OFFS)
+		| PCI_MSI_DOORBELL_MASK;
+	writel(reg, per_cpu_int_base + ARMADA_370_XP_IN_DRBEL_MSK_OFFS);
+	/* Unmask local doorbell interrupt */
+	writel(1, per_cpu_int_base + ARMADA_370_XP_INT_CLEAR_MASK_OFFS);
+}
+
+static int armada_370_xp_msi_init(struct device_node *node,
+				  phys_addr_t main_int_phys_base)
+{
 	msi_doorbell_addr =3D main_int_phys_base +
 		ARMADA_370_XP_SW_TRIG_INT_OFFS;
=20
@@ -287,18 +311,13 @@ static int armada_370_xp_msi_init(struct device_node *n=
ode,
 		return -ENOMEM;
 	}
=20
-	reg =3D readl(per_cpu_int_base + ARMADA_370_XP_IN_DRBEL_MSK_OFFS)
-		| PCI_MSI_DOORBELL_MASK;
-
-	writel(reg, per_cpu_int_base +
-	       ARMADA_370_XP_IN_DRBEL_MSK_OFFS);
-
-	/* Unmask IPI interrupt */
-	writel(1, per_cpu_int_base + ARMADA_370_XP_INT_CLEAR_MASK_OFFS);
+	armada_370_xp_msi_reenable_percpu();
=20
 	return 0;
 }
 #else
+static void armada_370_xp_msi_reenable_percpu(void) {}
+
 static inline int armada_370_xp_msi_init(struct device_node *node,
 					 phys_addr_t main_int_phys_base)
 {
@@ -308,7 +327,16 @@ static inline int armada_370_xp_msi_init(struct device_n=
ode *node,
=20
 static void armada_xp_mpic_perf_init(void)
 {
-	unsigned long cpuid =3D cpu_logical_map(smp_processor_id());
+	unsigned long cpuid;
+
+	/*
+	 * This Performance Counter Overflow interrupt is specific for
+	 * Armada 370 and XP. It is not available on Armada 375, 38x and 39x.
+	 */
+	if (!of_machine_is_compatible("marvell,armada-370-xp"))
+		return;
+
+	cpuid =3D cpu_logical_map(smp_processor_id());
=20
 	/* Enable Performance Counter Overflow interrupts */
 	writel(ARMADA_370_XP_INT_CAUSE_PERF(cpuid),
@@ -501,6 +529,8 @@ static void armada_xp_mpic_reenable_percpu(void)
 	}
=20
 	ipi_resume();
+
+	armada_370_xp_msi_reenable_percpu();
 }
=20
 static int armada_xp_mpic_starting_cpu(unsigned int cpu)
diff --git a/drivers/irqchip/irq-aspeed-i2c-ic.c b/drivers/irqchip/irq-aspeed=
-i2c-ic.c
index a47db16ff960..9c9fc3e2967e 100644
--- a/drivers/irqchip/irq-aspeed-i2c-ic.c
+++ b/drivers/irqchip/irq-aspeed-i2c-ic.c
@@ -77,8 +77,8 @@ static int __init aspeed_i2c_ic_of_init(struct device_node =
*node,
 	}
=20
 	i2c_ic->parent_irq =3D irq_of_parse_and_map(node, 0);
-	if (i2c_ic->parent_irq < 0) {
-		ret =3D i2c_ic->parent_irq;
+	if (!i2c_ic->parent_irq) {
+		ret =3D -EINVAL;
 		goto err_iounmap;
 	}
=20
diff --git a/drivers/irqchip/irq-aspeed-scu-ic.c b/drivers/irqchip/irq-aspeed=
-scu-ic.c
index 18b77c3e6db4..279e92cf0b16 100644
--- a/drivers/irqchip/irq-aspeed-scu-ic.c
+++ b/drivers/irqchip/irq-aspeed-scu-ic.c
@@ -157,8 +157,8 @@ static int aspeed_scu_ic_of_init_common(struct aspeed_scu=
_ic *scu_ic,
 	}
=20
 	irq =3D irq_of_parse_and_map(node, 0);
-	if (irq < 0) {
-		rc =3D irq;
+	if (!irq) {
+		rc =3D -EINVAL;
 		goto err;
 	}
=20
diff --git a/drivers/irqchip/irq-bcm6345-l1.c b/drivers/irqchip/irq-bcm6345-l=
1.c
index fd079215c17f..142a7431745f 100644
--- a/drivers/irqchip/irq-bcm6345-l1.c
+++ b/drivers/irqchip/irq-bcm6345-l1.c
@@ -315,7 +315,7 @@ static int __init bcm6345_l1_of_init(struct device_node *=
dn,
 			cpumask_set_cpu(idx, &intc->cpumask);
 	}
=20
-	if (!cpumask_weight(&intc->cpumask)) {
+	if (cpumask_empty(&intc->cpumask)) {
 		ret =3D -ENODEV;
 		goto out_free;
 	}
diff --git a/drivers/irqchip/irq-csky-apb-intc.c b/drivers/irqchip/irq-csky-a=
pb-intc.c
index d36f536506ba..42d8a2438ebc 100644
--- a/drivers/irqchip/irq-csky-apb-intc.c
+++ b/drivers/irqchip/irq-csky-apb-intc.c
@@ -136,11 +136,11 @@ static inline bool handle_irq_perbit(struct pt_regs *re=
gs, u32 hwirq,
 				     u32 irq_base)
 {
 	if (hwirq =3D=3D 0)
-		return 0;
+		return false;
=20
 	generic_handle_domain_irq(root_domain, irq_base + __fls(hwirq));
=20
-	return 1;
+	return true;
 }
=20
 /* gx6605s 64 irqs interrupt controller */
diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-it=
s.c
index a0fc764ec9dc..5ff09de6c48f 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -1624,7 +1624,7 @@ static int its_select_cpu(struct irq_data *d,
=20
 		cpu =3D cpumask_pick_least_loaded(d, tmpmask);
 	} else {
-		cpumask_and(tmpmask, irq_data_get_affinity_mask(d), cpu_online_mask);
+		cpumask_copy(tmpmask, aff_mask);
=20
 		/* If we cannot cross sockets, limit the search to that node */
 		if ((its_dev->its->flags & ITS_FLAGS_WORKAROUND_CAVIUM_23144) &&
diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index b252d5534547..2be8dea6b6b0 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -352,28 +352,27 @@ static int gic_peek_irq(struct irq_data *d, u32 offset)
=20
 static void gic_poke_irq(struct irq_data *d, u32 offset)
 {
-	void (*rwp_wait)(void);
 	void __iomem *base;
 	u32 index, mask;
=20
 	offset =3D convert_offset_index(d, offset, &index);
 	mask =3D 1 << (index % 32);
=20
-	if (gic_irq_in_rdist(d)) {
+	if (gic_irq_in_rdist(d))
 		base =3D gic_data_rdist_sgi_base();
-		rwp_wait =3D gic_redist_wait_for_rwp;
-	} else {
+	else
 		base =3D gic_data.dist_base;
-		rwp_wait =3D gic_dist_wait_for_rwp;
-	}
=20
 	writel_relaxed(mask, base + offset + (index / 32) * 4);
-	rwp_wait();
 }
=20
 static void gic_mask_irq(struct irq_data *d)
 {
 	gic_poke_irq(d, GICD_ICENABLER);
+	if (gic_irq_in_rdist(d))
+		gic_redist_wait_for_rwp();
+	else
+		gic_dist_wait_for_rwp();
 }
=20
 static void gic_eoimode1_mask_irq(struct irq_data *d)
@@ -420,7 +419,11 @@ static int gic_irq_set_irqchip_state(struct irq_data *d,
 		break;
=20
 	case IRQCHIP_STATE_MASKED:
-		reg =3D val ? GICD_ICENABLER : GICD_ISENABLER;
+		if (val) {
+			gic_mask_irq(d);
+			return 0;
+		}
+		reg =3D GICD_ISENABLER;
 		break;
=20
 	default:
@@ -556,7 +559,8 @@ static void gic_irq_nmi_teardown(struct irq_data *d)
=20
 static void gic_eoi_irq(struct irq_data *d)
 {
-	gic_write_eoir(gic_irq(d));
+	write_gicreg(gic_irq(d), ICC_EOIR1_EL1);
+	isb();
 }
=20
 static void gic_eoimode1_eoi_irq(struct irq_data *d)
@@ -574,7 +578,6 @@ static int gic_set_type(struct irq_data *d, unsigned int =
type)
 {
 	enum gic_intid_range range;
 	unsigned int irq =3D gic_irq(d);
-	void (*rwp_wait)(void);
 	void __iomem *base;
 	u32 offset, index;
 	int ret;
@@ -590,17 +593,14 @@ static int gic_set_type(struct irq_data *d, unsigned in=
t type)
 	    type !=3D IRQ_TYPE_LEVEL_HIGH && type !=3D IRQ_TYPE_EDGE_RISING)
 		return -EINVAL;
=20
-	if (gic_irq_in_rdist(d)) {
+	if (gic_irq_in_rdist(d))
 		base =3D gic_data_rdist_sgi_base();
-		rwp_wait =3D gic_redist_wait_for_rwp;
-	} else {
+	else
 		base =3D gic_data.dist_base;
-		rwp_wait =3D gic_dist_wait_for_rwp;
-	}
=20
 	offset =3D convert_offset_index(d, GICD_ICFGR, &index);
=20
-	ret =3D gic_configure_irq(index, type, base + offset, rwp_wait);
+	ret =3D gic_configure_irq(index, type, base + offset, NULL);
 	if (ret && (range =3D=3D PPI_RANGE || range =3D=3D EPPI_RANGE)) {
 		/* Misconfigured PPIs are usually not fatal */
 		pr_warn("GIC: PPI INTID%d is secure or misconfigured\n", irq);
@@ -640,82 +640,101 @@ static void gic_deactivate_unhandled(u32 irqnr)
 		if (irqnr < 8192)
 			gic_write_dir(irqnr);
 	} else {
-		gic_write_eoir(irqnr);
+		write_gicreg(irqnr, ICC_EOIR1_EL1);
+		isb();
 	}
 }
=20
-static inline void gic_handle_nmi(u32 irqnr, struct pt_regs *regs)
+/*
+ * Follow a read of the IAR with any HW maintenance that needs to happen pri=
or
+ * to invoking the relevant IRQ handler. We must do two things:
+ *
+ * (1) Ensure instruction ordering between a read of IAR and subsequent
+ *     instructions in the IRQ handler using an ISB.
+ *
+ *     It is possible for the IAR to report an IRQ which was signalled *afte=
r*
+ *     the CPU took an IRQ exception as multiple interrupts can race to be
+ *     recognized by the GIC, earlier interrupts could be withdrawn, and/or
+ *     later interrupts could be prioritized by the GIC.
+ *
+ *     For devices which are tightly coupled to the CPU, such as PMUs, a
+ *     context synchronization event is necessary to ensure that system
+ *     register state is not stale, as these may have been indirectly written
+ *     *after* exception entry.
+ *
+ * (2) Deactivate the interrupt when EOI mode 1 is in use.
+ */
+static inline void gic_complete_ack(u32 irqnr)
 {
-	bool irqs_enabled =3D interrupts_enabled(regs);
-	int err;
-
-	if (irqs_enabled)
-		nmi_enter();
-
 	if (static_branch_likely(&supports_deactivate_key))
-		gic_write_eoir(irqnr);
-	/*
-	 * Leave the PSR.I bit set to prevent other NMIs to be
-	 * received while handling this one.
-	 * PSR.I will be restored when we ERET to the
-	 * interrupted context.
-	 */
-	err =3D generic_handle_domain_nmi(gic_data.domain, irqnr);
-	if (err)
-		gic_deactivate_unhandled(irqnr);
+		write_gicreg(irqnr, ICC_EOIR1_EL1);
=20
-	if (irqs_enabled)
-		nmi_exit();
+	isb();
 }
=20
-static u32 do_read_iar(struct pt_regs *regs)
+static bool gic_rpr_is_nmi_prio(void)
 {
-	u32 iar;
+	if (!gic_supports_nmi())
+		return false;
=20
-	if (gic_supports_nmi() && unlikely(!interrupts_enabled(regs))) {
-		u64 pmr;
+	return unlikely(gic_read_rpr() =3D=3D GICD_INT_RPR_PRI(GICD_INT_NMI_PRI));
+}
=20
-		/*
-		 * We were in a context with IRQs disabled. However, the
-		 * entry code has set PMR to a value that allows any
-		 * interrupt to be acknowledged, and not just NMIs. This can
-		 * lead to surprising effects if the NMI has been retired in
-		 * the meantime, and that there is an IRQ pending. The IRQ
-		 * would then be taken in NMI context, something that nobody
-		 * wants to debug twice.
-		 *
-		 * Until we sort this, drop PMR again to a level that will
-		 * actually only allow NMIs before reading IAR, and then
-		 * restore it to what it was.
-		 */
-		pmr =3D gic_read_pmr();
-		gic_pmr_mask_irqs();
-		isb();
+static bool gic_irqnr_is_special(u32 irqnr)
+{
+	return irqnr >=3D 1020 && irqnr <=3D 1023;
+}
=20
-		iar =3D gic_read_iar();
+static void __gic_handle_irq(u32 irqnr, struct pt_regs *regs)
+{
+	if (gic_irqnr_is_special(irqnr))
+		return;
=20
-		gic_write_pmr(pmr);
-	} else {
-		iar =3D gic_read_iar();
+	gic_complete_ack(irqnr);
+
+	if (generic_handle_domain_irq(gic_data.domain, irqnr)) {
+		WARN_ONCE(true, "Unexpected interrupt (irqnr %u)\n", irqnr);
+		gic_deactivate_unhandled(irqnr);
 	}
+}
+
+static void __gic_handle_nmi(u32 irqnr, struct pt_regs *regs)
+{
+	if (gic_irqnr_is_special(irqnr))
+		return;
+
+	gic_complete_ack(irqnr);
=20
-	return iar;
+	if (generic_handle_domain_nmi(gic_data.domain, irqnr)) {
+		WARN_ONCE(true, "Unexpected pseudo-NMI (irqnr %u)\n", irqnr);
+		gic_deactivate_unhandled(irqnr);
+	}
 }
=20
-static asmlinkage void __exception_irq_entry gic_handle_irq(struct pt_regs *=
regs)
+/*
+ * An exception has been taken from a context with IRQs enabled, and this co=
uld
+ * be an IRQ or an NMI.
+ *
+ * The entry code called us with DAIF.IF set to keep NMIs masked. We must cl=
ear
+ * DAIF.IF (and update ICC_PMR_EL1 to mask regular IRQs) prior to returning,
+ * after handling any NMI but before handling any IRQ.
+ *
+ * The entry code has performed IRQ entry, and if an NMI is detected we must
+ * perform NMI entry/exit around invoking the handler.
+ */
+static void __gic_handle_irq_from_irqson(struct pt_regs *regs)
 {
+	bool is_nmi;
 	u32 irqnr;
=20
-	irqnr =3D do_read_iar(regs);
+	irqnr =3D gic_read_iar();
=20
-	/* Check for special IDs first */
-	if ((irqnr >=3D 1020 && irqnr <=3D 1023))
-		return;
+	is_nmi =3D gic_rpr_is_nmi_prio();
=20
-	if (gic_supports_nmi() &&
-	    unlikely(gic_read_rpr() =3D=3D GICD_INT_RPR_PRI(GICD_INT_NMI_PRI))) {
-		gic_handle_nmi(irqnr, regs);
-		return;
+	if (is_nmi) {
+		nmi_enter();
+		__gic_handle_nmi(irqnr, regs);
+		nmi_exit();
 	}
=20
 	if (gic_prio_masking_enabled()) {
@@ -723,15 +742,52 @@ static asmlinkage void __exception_irq_entry gic_handle=
_irq(struct pt_regs *regs
 		gic_arch_enable_irqs();
 	}
=20
-	if (static_branch_likely(&supports_deactivate_key))
-		gic_write_eoir(irqnr);
-	else
-		isb();
+	if (!is_nmi)
+		__gic_handle_irq(irqnr, regs);
+}
=20
-	if (generic_handle_domain_irq(gic_data.domain, irqnr)) {
-		WARN_ONCE(true, "Unexpected interrupt received!\n");
-		gic_deactivate_unhandled(irqnr);
-	}
+/*
+ * An exception has been taken from a context with IRQs disabled, which can =
only
+ * be an NMI.
+ *
+ * The entry code called us with DAIF.IF set to keep NMIs masked. We must le=
ave
+ * DAIF.IF (and ICC_PMR_EL1) unchanged.
+ *
+ * The entry code has performed NMI entry.
+ */
+static void __gic_handle_irq_from_irqsoff(struct pt_regs *regs)
+{
+	u64 pmr;
+	u32 irqnr;
+
+	/*
+	 * We were in a context with IRQs disabled. However, the
+	 * entry code has set PMR to a value that allows any
+	 * interrupt to be acknowledged, and not just NMIs. This can
+	 * lead to surprising effects if the NMI has been retired in
+	 * the meantime, and that there is an IRQ pending. The IRQ
+	 * would then be taken in NMI context, something that nobody
+	 * wants to debug twice.
+	 *
+	 * Until we sort this, drop PMR again to a level that will
+	 * actually only allow NMIs before reading IAR, and then
+	 * restore it to what it was.
+	 */
+	pmr =3D gic_read_pmr();
+	gic_pmr_mask_irqs();
+	isb();
+	irqnr =3D gic_read_iar();
+	gic_write_pmr(pmr);
+
+	__gic_handle_nmi(irqnr, regs);
+}
+
+static asmlinkage void __exception_irq_entry gic_handle_irq(struct pt_regs *=
regs)
+{
+	if (unlikely(gic_supports_nmi() && !interrupts_enabled(regs)))
+		__gic_handle_irq_from_irqsoff(regs);
+	else
+		__gic_handle_irq_from_irqson(regs);
 }
=20
 static u32 gic_get_pribits(void)
@@ -807,8 +863,8 @@ static void __init gic_dist_init(void)
 	for (i =3D 0; i < GIC_ESPI_NR; i +=3D 4)
 		writel_relaxed(GICD_INT_DEF_PRI_X4, base + GICD_IPRIORITYRnE + i);
=20
-	/* Now do the common stuff, and wait for the distributor to drain */
-	gic_dist_config(base, GIC_LINE_NR, gic_dist_wait_for_rwp);
+	/* Now do the common stuff */
+	gic_dist_config(base, GIC_LINE_NR, NULL);
=20
 	val =3D GICD_CTLR_ARE_NS | GICD_CTLR_ENABLE_G1A | GICD_CTLR_ENABLE_G1;
 	if (gic_data.rdists.gicd_typer2 & GICD_TYPER2_nASSGIcap) {
@@ -816,8 +872,9 @@ static void __init gic_dist_init(void)
 		val |=3D GICD_CTLR_nASSGIreq;
 	}
=20
-	/* Enable distributor with ARE, Group1 */
+	/* Enable distributor with ARE, Group1, and wait for it to drain */
 	writel_relaxed(val, base + GICD_CTLR);
+	gic_dist_wait_for_rwp();
=20
 	/*
 	 * Set all global interrupts to the boot CPU only. ARE must be
@@ -919,6 +976,7 @@ static int __gic_update_rdist_properties(struct redist_re=
gion *region,
 					 void __iomem *ptr)
 {
 	u64 typer =3D gic_read_typer(ptr + GICR_TYPER);
+	u32 ctlr =3D readl_relaxed(ptr + GICR_CTLR);
=20
 	/* Boot-time cleanip */
 	if ((typer & GICR_TYPER_VLPIS) && (typer & GICR_TYPER_RVPEID)) {
@@ -938,9 +996,18 @@ static int __gic_update_rdist_properties(struct redist_r=
egion *region,
=20
 	gic_data.rdists.has_vlpis &=3D !!(typer & GICR_TYPER_VLPIS);
=20
-	/* RVPEID implies some form of DirectLPI, no matter what the doc says... :-=
/ */
+	/*
+	 * TYPER.RVPEID implies some form of DirectLPI, no matter what the
+	 * doc says... :-/ And CTLR.IR implies another subset of DirectLPI
+	 * that the ITS driver can make use of for LPIs (and not VLPIs).
+	 *
+	 * These are 3 different ways to express the same thing, depending
+	 * on the revision of the architecture and its relaxations over
+	 * time. Just group them under the 'direct_lpi' banner.
+	 */
 	gic_data.rdists.has_rvpeid &=3D !!(typer & GICR_TYPER_RVPEID);
 	gic_data.rdists.has_direct_lpi &=3D (!!(typer & GICR_TYPER_DirectLPIS) |
+					   !!(ctlr & GICR_CTLR_IR) |
 					   gic_data.rdists.has_rvpeid);
 	gic_data.rdists.has_vpend_valid_dirty &=3D !!(typer & GICR_TYPER_DIRTY);
=20
@@ -962,7 +1029,11 @@ static void gic_update_rdist_properties(void)
 	gic_iterate_rdists(__gic_update_rdist_properties);
 	if (WARN_ON(gic_data.ppi_nr =3D=3D UINT_MAX))
 		gic_data.ppi_nr =3D 0;
-	pr_info("%d PPIs implemented\n", gic_data.ppi_nr);
+	pr_info("GICv3 features: %d PPIs%s%s\n",
+		gic_data.ppi_nr,
+		gic_data.has_rss ? ", RSS" : "",
+		gic_data.rdists.has_direct_lpi ? ", DirectLPI" : "");
+
 	if (gic_data.rdists.has_vlpis)
 		pr_info("GICv4 features: %s%s%s\n",
 			gic_data.rdists.has_direct_lpi ? "DirectLPI " : "",
@@ -1284,8 +1355,6 @@ static int gic_set_affinity(struct irq_data *d, const s=
truct cpumask *mask_val,
 	 */
 	if (enabled)
 		gic_unmask_irq(d);
-	else
-		gic_dist_wait_for_rwp();
=20
 	irq_data_update_effective_affinity(d, cpumask_of(cpu));
=20
@@ -1803,8 +1872,6 @@ static int __init gic_init_bases(void __iomem *dist_bas=
e,
 	irq_domain_update_bus_token(gic_data.domain, DOMAIN_BUS_WIRED);
=20
 	gic_data.has_rss =3D !!(typer & GICD_TYPER_RSS);
-	pr_info("Distributor has %sRange Selector support\n",
-		gic_data.has_rss ? "" : "no ");
=20
 	if (typer & GICD_TYPER_MBIS) {
 		err =3D mbi_init(handle, gic_data.domain);
@@ -1980,10 +2047,10 @@ static int __init gic_of_init(struct device_node *nod=
e, struct device_node *pare
 	u32 nr_redist_regions;
 	int err, i;
=20
-	dist_base =3D of_iomap(node, 0);
-	if (!dist_base) {
+	dist_base =3D of_io_request_and_map(node, 0, "GICD");
+	if (IS_ERR(dist_base)) {
 		pr_err("%pOF: unable to map gic dist registers\n", node);
-		return -ENXIO;
+		return PTR_ERR(dist_base);
 	}
=20
 	err =3D gic_validate_dist_version(dist_base);
@@ -2007,8 +2074,8 @@ static int __init gic_of_init(struct device_node *node,=
 struct device_node *pare
 		int ret;
=20
 		ret =3D of_address_to_resource(node, 1 + i, &res);
-		rdist_regs[i].redist_base =3D of_iomap(node, 1 + i);
-		if (ret || !rdist_regs[i].redist_base) {
+		rdist_regs[i].redist_base =3D of_io_request_and_map(node, 1 + i, "GICR");
+		if (ret || IS_ERR(rdist_regs[i].redist_base)) {
 			pr_err("%pOF: couldn't map region %d\n", node, i);
 			err =3D -ENODEV;
 			goto out_unmap_rdist;
@@ -2034,7 +2101,7 @@ static int __init gic_of_init(struct device_node *node,=
 struct device_node *pare
=20
 out_unmap_rdist:
 	for (i =3D 0; i < nr_redist_regions; i++)
-		if (rdist_regs[i].redist_base)
+		if (rdist_regs[i].redist_base && !IS_ERR(rdist_regs[i].redist_base))
 			iounmap(rdist_regs[i].redist_base);
 	kfree(rdist_regs);
 out_unmap_dist:
@@ -2081,6 +2148,7 @@ gic_acpi_parse_madt_redist(union acpi_subtable_headers =
*header,
 		pr_err("Couldn't map GICR region @%llx\n", redist->base_address);
 		return -ENOMEM;
 	}
+	request_mem_region(redist->base_address, redist->length, "GICR");
=20
 	gic_acpi_register_redist(redist->base_address, redist_base);
 	return 0;
@@ -2103,6 +2171,7 @@ gic_acpi_parse_madt_gicc(union acpi_subtable_headers *h=
eader,
 	redist_base =3D ioremap(gicc->gicr_base_address, size);
 	if (!redist_base)
 		return -ENOMEM;
+	request_mem_region(gicc->gicr_base_address, size, "GICR");
=20
 	gic_acpi_register_redist(gicc->gicr_base_address, redist_base);
 	return 0;
@@ -2304,6 +2373,7 @@ gic_acpi_init(union acpi_subtable_headers *header, cons=
t unsigned long end)
 		pr_err("Unable to map GICD registers\n");
 		return -ENOMEM;
 	}
+	request_mem_region(dist->base_address, ACPI_GICV3_DIST_MEM_SIZE, "GICD");
=20
 	err =3D gic_validate_dist_version(acpi_data.dist_base);
 	if (err) {
diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index 09c710ecc387..820404cb56bc 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -1115,7 +1115,8 @@ static int gic_irq_domain_translate(struct irq_domain *=
d,
 		*type =3D fwspec->param[2] & IRQ_TYPE_SENSE_MASK;
=20
 		/* Make it clear that broken DTs are... broken */
-		WARN_ON(*type =3D=3D IRQ_TYPE_NONE);
+		WARN(*type =3D=3D IRQ_TYPE_NONE,
+		     "HW irq %ld has invalid type\n", *hwirq);
 		return 0;
 	}
=20
@@ -1132,7 +1133,8 @@ static int gic_irq_domain_translate(struct irq_domain *=
d,
 		*hwirq =3D fwspec->param[0];
 		*type =3D fwspec->param[1];
=20
-		WARN_ON(*type =3D=3D IRQ_TYPE_NONE);
+		WARN(*type =3D=3D IRQ_TYPE_NONE,
+		     "HW irq %ld has invalid type\n", *hwirq);
 		return 0;
 	}
=20
diff --git a/drivers/irqchip/irq-imx-irqsteer.c b/drivers/irqchip/irq-imx-irq=
steer.c
index 8d91a02593fc..96230a04ec23 100644
--- a/drivers/irqchip/irq-imx-irqsteer.c
+++ b/drivers/irqchip/irq-imx-irqsteer.c
@@ -12,6 +12,7 @@
 #include <linux/kernel.h>
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
+#include <linux/pm_runtime.h>
 #include <linux/spinlock.h>
=20
 #define CTRL_STRIDE_OFF(_t, _r)	(_t * 4 * _r)
@@ -70,7 +71,7 @@ static void imx_irqsteer_irq_mask(struct irq_data *d)
 	raw_spin_unlock_irqrestore(&data->lock, flags);
 }
=20
-static struct irq_chip imx_irqsteer_irq_chip =3D {
+static const struct irq_chip imx_irqsteer_irq_chip =3D {
 	.name		=3D "irqsteer",
 	.irq_mask	=3D imx_irqsteer_irq_mask,
 	.irq_unmask	=3D imx_irqsteer_irq_unmask,
@@ -175,7 +176,7 @@ static int imx_irqsteer_probe(struct platform_device *pde=
v)
 	data->irq_count =3D DIV_ROUND_UP(irqs_num, 64);
 	data->reg_num =3D irqs_num / 32;
=20
-	if (IS_ENABLED(CONFIG_PM_SLEEP)) {
+	if (IS_ENABLED(CONFIG_PM)) {
 		data->saved_reg =3D devm_kzalloc(&pdev->dev,
 					sizeof(u32) * data->reg_num,
 					GFP_KERNEL);
@@ -199,6 +200,7 @@ static int imx_irqsteer_probe(struct platform_device *pde=
v)
 		ret =3D -ENOMEM;
 		goto out;
 	}
+	irq_domain_set_pm_device(data->domain, &pdev->dev);
=20
 	if (!data->irq_count || data->irq_count > CHAN_MAX_OUTPUT_INT) {
 		ret =3D -EINVAL;
@@ -219,6 +221,9 @@ static int imx_irqsteer_probe(struct platform_device *pde=
v)
=20
 	platform_set_drvdata(pdev, data);
=20
+	pm_runtime_set_active(&pdev->dev);
+	pm_runtime_enable(&pdev->dev);
+
 	return 0;
 out:
 	clk_disable_unprepare(data->ipg_clk);
@@ -241,7 +246,7 @@ static int imx_irqsteer_remove(struct platform_device *pd=
ev)
 	return 0;
 }
=20
-#ifdef CONFIG_PM_SLEEP
+#ifdef CONFIG_PM
 static void imx_irqsteer_save_regs(struct irqsteer_data *data)
 {
 	int i;
@@ -288,7 +293,10 @@ static int imx_irqsteer_resume(struct device *dev)
 #endif
=20
 static const struct dev_pm_ops imx_irqsteer_pm_ops =3D {
-	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(imx_irqsteer_suspend, imx_irqsteer_resume)
+	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
+				      pm_runtime_force_resume)
+	SET_RUNTIME_PM_OPS(imx_irqsteer_suspend,
+			   imx_irqsteer_resume, NULL)
 };
=20
 static const struct of_device_id imx_irqsteer_dt_ids[] =3D {
diff --git a/drivers/irqchip/irq-sni-exiu.c b/drivers/irqchip/irq-sni-exiu.c
index abd011fcecf4..c7db617e1a2f 100644
--- a/drivers/irqchip/irq-sni-exiu.c
+++ b/drivers/irqchip/irq-sni-exiu.c
@@ -37,11 +37,26 @@ struct exiu_irq_data {
 	u32		spi_base;
 };
=20
-static void exiu_irq_eoi(struct irq_data *d)
+static void exiu_irq_ack(struct irq_data *d)
 {
 	struct exiu_irq_data *data =3D irq_data_get_irq_chip_data(d);
=20
 	writel(BIT(d->hwirq), data->base + EIREQCLR);
+}
+
+static void exiu_irq_eoi(struct irq_data *d)
+{
+	struct exiu_irq_data *data =3D irq_data_get_irq_chip_data(d);
+
+	/*
+	 * Level triggered interrupts are latched and must be cleared during
+	 * EOI or the interrupt will be jammed on. Of course if a level
+	 * triggered interrupt is still asserted then the write will not clear
+	 * the interrupt.
+	 */
+	if (irqd_is_level_type(d))
+		writel(BIT(d->hwirq), data->base + EIREQCLR);
+
 	irq_chip_eoi_parent(d);
 }
=20
@@ -91,10 +106,13 @@ static int exiu_irq_set_type(struct irq_data *d, unsigne=
d int type)
 	writel_relaxed(val, data->base + EILVL);
=20
 	val =3D readl_relaxed(data->base + EIEDG);
-	if (type =3D=3D IRQ_TYPE_LEVEL_LOW || type =3D=3D IRQ_TYPE_LEVEL_HIGH)
+	if (type =3D=3D IRQ_TYPE_LEVEL_LOW || type =3D=3D IRQ_TYPE_LEVEL_HIGH) {
 		val &=3D ~BIT(d->hwirq);
-	else
+		irq_set_handler_locked(d, handle_fasteoi_irq);
+	} else {
 		val |=3D BIT(d->hwirq);
+		irq_set_handler_locked(d, handle_fasteoi_ack_irq);
+	}
 	writel_relaxed(val, data->base + EIEDG);
=20
 	writel_relaxed(BIT(d->hwirq), data->base + EIREQCLR);
@@ -104,6 +122,7 @@ static int exiu_irq_set_type(struct irq_data *d, unsigned=
 int type)
=20
 static struct irq_chip exiu_irq_chip =3D {
 	.name			=3D "EXIU",
+	.irq_ack		=3D exiu_irq_ack,
 	.irq_eoi		=3D exiu_irq_eoi,
 	.irq_enable		=3D exiu_irq_enable,
 	.irq_mask		=3D exiu_irq_mask,
diff --git a/drivers/irqchip/irq-sun6i-r.c b/drivers/irqchip/irq-sun6i-r.c
index 4cd3e533740b..a01e44049415 100644
--- a/drivers/irqchip/irq-sun6i-r.c
+++ b/drivers/irqchip/irq-sun6i-r.c
@@ -249,11 +249,13 @@ static int sun6i_r_intc_domain_alloc(struct irq_domain =
*domain,
 	for (i =3D 0; i < nr_irqs; ++i, ++hwirq, ++virq) {
 		if (hwirq =3D=3D nmi_hwirq) {
 			irq_domain_set_hwirq_and_chip(domain, virq, hwirq,
-						      &sun6i_r_intc_nmi_chip, 0);
+						      &sun6i_r_intc_nmi_chip,
+						      NULL);
 			irq_set_handler(virq, handle_fasteoi_ack_irq);
 		} else {
 			irq_domain_set_hwirq_and_chip(domain, virq, hwirq,
-						      &sun6i_r_intc_wakeup_chip, 0);
+						      &sun6i_r_intc_wakeup_chip,
+						      NULL);
 		}
 	}
=20
diff --git a/drivers/irqchip/irq-xtensa-mx.c b/drivers/irqchip/irq-xtensa-mx.c
index 27933338f7b3..8c581c985aa7 100644
--- a/drivers/irqchip/irq-xtensa-mx.c
+++ b/drivers/irqchip/irq-xtensa-mx.c
@@ -151,14 +151,25 @@ static struct irq_chip xtensa_mx_irq_chip =3D {
 	.irq_set_affinity =3D xtensa_mx_irq_set_affinity,
 };
=20
+static void __init xtensa_mx_init_common(struct irq_domain *root_domain)
+{
+	unsigned int i;
+
+	irq_set_default_host(root_domain);
+	secondary_init_irq();
+
+	/* Initialize default IRQ routing to CPU 0 */
+	for (i =3D 0; i < XCHAL_NUM_EXTINTERRUPTS; ++i)
+		set_er(1, MIROUT(i));
+}
+
 int __init xtensa_mx_init_legacy(struct device_node *interrupt_parent)
 {
 	struct irq_domain *root_domain =3D
 		irq_domain_add_legacy(NULL, NR_IRQS - 1, 1, 0,
 				&xtensa_mx_irq_domain_ops,
 				&xtensa_mx_irq_chip);
-	irq_set_default_host(root_domain);
-	secondary_init_irq();
+	xtensa_mx_init_common(root_domain);
 	return 0;
 }
=20
@@ -168,8 +179,7 @@ static int __init xtensa_mx_init(struct device_node *np,
 	struct irq_domain *root_domain =3D
 		irq_domain_add_linear(np, NR_IRQS, &xtensa_mx_irq_domain_ops,
 				&xtensa_mx_irq_chip);
-	irq_set_default_host(root_domain);
-	secondary_init_irq();
+	xtensa_mx_init_common(root_domain);
 	return 0;
 }
 IRQCHIP_DECLARE(xtensa_mx_irq_chip, "cdns,xtensa-mx", xtensa_mx_init);
diff --git a/drivers/pinctrl/pinctrl-amd.c b/drivers/pinctrl/pinctrl-amd.c
index 1a7d686494ff..0645c2c24f50 100644
--- a/drivers/pinctrl/pinctrl-amd.c
+++ b/drivers/pinctrl/pinctrl-amd.c
@@ -387,6 +387,8 @@ static void amd_gpio_irq_enable(struct irq_data *d)
 	struct gpio_chip *gc =3D irq_data_get_irq_chip_data(d);
 	struct amd_gpio *gpio_dev =3D gpiochip_get_data(gc);
=20
+	gpiochip_enable_irq(gc, d->hwirq);
+
 	raw_spin_lock_irqsave(&gpio_dev->lock, flags);
 	pin_reg =3D readl(gpio_dev->base + (d->hwirq)*4);
 	pin_reg |=3D BIT(INTERRUPT_ENABLE_OFF);
@@ -408,6 +410,8 @@ static void amd_gpio_irq_disable(struct irq_data *d)
 	pin_reg &=3D ~BIT(INTERRUPT_MASK_OFF);
 	writel(pin_reg, gpio_dev->base + (d->hwirq)*4);
 	raw_spin_unlock_irqrestore(&gpio_dev->lock, flags);
+
+	gpiochip_disable_irq(gc, d->hwirq);
 }
=20
 static void amd_gpio_irq_mask(struct irq_data *d)
@@ -577,7 +581,7 @@ static void amd_irq_ack(struct irq_data *d)
 	*/
 }
=20
-static struct irq_chip amd_gpio_irqchip =3D {
+static const struct irq_chip amd_gpio_irqchip =3D {
 	.name         =3D "amd_gpio",
 	.irq_ack      =3D amd_irq_ack,
 	.irq_enable   =3D amd_gpio_irq_enable,
@@ -593,7 +597,8 @@ static struct irq_chip amd_gpio_irqchip =3D {
 	 * the wake event. Otherwise the wake event will never clear and
 	 * prevent the system from suspending.
 	 */
-	.flags        =3D IRQCHIP_ENABLE_WAKEUP_ON_SUSPEND,
+	.flags        =3D IRQCHIP_ENABLE_WAKEUP_ON_SUSPEND | IRQCHIP_IMMUTABLE,
+	GPIOCHIP_IRQ_RESOURCE_HELPERS,
 };
=20
 #define PIN_IRQ_PENDING	(BIT(INTERRUPT_STS_OFF) | BIT(WAKE_STS_OFF))
@@ -1026,7 +1031,7 @@ static int amd_gpio_probe(struct platform_device *pdev)
 	amd_gpio_irq_init(gpio_dev);
=20
 	girq =3D &gpio_dev->gc.irq;
-	girq->chip =3D &amd_gpio_irqchip;
+	gpio_irq_chip_set_chip(girq, &amd_gpio_irqchip);
 	/* This will let us handle the parent IRQ in the driver */
 	girq->parent_handler =3D NULL;
 	girq->num_parents =3D 0;
diff --git a/drivers/pinctrl/pinctrl-apple-gpio.c b/drivers/pinctrl/pinctrl-a=
pple-gpio.c
index 72f4dd2466e1..5e610849dfc3 100644
--- a/drivers/pinctrl/pinctrl-apple-gpio.c
+++ b/drivers/pinctrl/pinctrl-apple-gpio.c
@@ -36,7 +36,6 @@ struct apple_gpio_pinctrl {
=20
 	struct pinctrl_desc pinctrl_desc;
 	struct gpio_chip gpio_chip;
-	struct irq_chip irq_chip;
 	u8 irqgrps[];
 };
=20
@@ -275,17 +274,21 @@ static unsigned int apple_gpio_irq_type(unsigned int ty=
pe)
=20
 static void apple_gpio_irq_mask(struct irq_data *data)
 {
-	struct apple_gpio_pinctrl *pctl =3D gpiochip_get_data(irq_data_get_irq_chip=
_data(data));
+	struct gpio_chip *gc =3D irq_data_get_irq_chip_data(data);
+	struct apple_gpio_pinctrl *pctl =3D gpiochip_get_data(gc);
=20
 	apple_gpio_set_reg(pctl, data->hwirq, REG_GPIOx_MODE,
 	                   FIELD_PREP(REG_GPIOx_MODE, REG_GPIOx_IN_IRQ_OFF));
+	gpiochip_disable_irq(gc, data->hwirq);
 }
=20
 static void apple_gpio_irq_unmask(struct irq_data *data)
 {
-	struct apple_gpio_pinctrl *pctl =3D gpiochip_get_data(irq_data_get_irq_chip=
_data(data));
+	struct gpio_chip *gc =3D irq_data_get_irq_chip_data(data);
+	struct apple_gpio_pinctrl *pctl =3D gpiochip_get_data(gc);
 	unsigned int irqtype =3D apple_gpio_irq_type(irqd_get_trigger_type(data));
=20
+	gpiochip_enable_irq(gc, data->hwirq);
 	apple_gpio_set_reg(pctl, data->hwirq, REG_GPIOx_MODE,
 	                   FIELD_PREP(REG_GPIOx_MODE, irqtype));
 }
@@ -343,13 +346,15 @@ static void apple_gpio_irq_handler(struct irq_desc *des=
c)
 	chained_irq_exit(chip, desc);
 }
=20
-static struct irq_chip apple_gpio_irqchip =3D {
-	.name		=3D "Apple-GPIO",
-	.irq_startup	=3D apple_gpio_irq_startup,
-	.irq_ack	=3D apple_gpio_irq_ack,
-	.irq_mask	=3D apple_gpio_irq_mask,
-	.irq_unmask	=3D apple_gpio_irq_unmask,
-	.irq_set_type	=3D apple_gpio_irq_set_type,
+static const struct irq_chip apple_gpio_irqchip =3D {
+	.name			=3D "Apple-GPIO",
+	.irq_startup		=3D apple_gpio_irq_startup,
+	.irq_ack		=3D apple_gpio_irq_ack,
+	.irq_mask		=3D apple_gpio_irq_mask,
+	.irq_unmask		=3D apple_gpio_irq_unmask,
+	.irq_set_type		=3D apple_gpio_irq_set_type,
+	.flags			=3D IRQCHIP_IMMUTABLE,
+	GPIOCHIP_IRQ_RESOURCE_HELPERS,
 };
=20
 /* Probe & register */
@@ -360,8 +365,6 @@ static int apple_gpio_register(struct apple_gpio_pinctrl =
*pctl)
 	void **irq_data =3D NULL;
 	int ret;
=20
-	pctl->irq_chip =3D apple_gpio_irqchip;
-
 	pctl->gpio_chip.label =3D dev_name(pctl->dev);
 	pctl->gpio_chip.request =3D gpiochip_generic_request;
 	pctl->gpio_chip.free =3D gpiochip_generic_free;
@@ -377,7 +380,7 @@ static int apple_gpio_register(struct apple_gpio_pinctrl =
*pctl)
 	if (girq->num_parents) {
 		int i;
=20
-		girq->chip =3D &pctl->irq_chip;
+		gpio_irq_chip_set_chip(girq, &apple_gpio_irqchip);
 		girq->parent_handler =3D apple_gpio_irq_handler;
=20
 		girq->parents =3D kmalloc_array(girq->num_parents,
diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c b/drivers/pinctrl/qcom/pinctr=
l-msm.c
index 966ea6622ff3..a2abfe987ab1 100644
--- a/drivers/pinctrl/qcom/pinctrl-msm.c
+++ b/drivers/pinctrl/qcom/pinctrl-msm.c
@@ -42,7 +42,6 @@
  * @chip:           gpiochip handle.
  * @desc:           pin controller descriptor
  * @restart_nb:     restart notifier block.
- * @irq_chip:       irq chip information
  * @irq:            parent irq for the TLMM irq_chip.
  * @intr_target_use_scm: route irq to application cpu using scm calls
  * @lock:           Spinlock to protect register resources as well
@@ -63,7 +62,6 @@ struct msm_pinctrl {
 	struct pinctrl_desc desc;
 	struct notifier_block restart_nb;
=20
-	struct irq_chip irq_chip;
 	int irq;
=20
 	bool intr_target_use_scm;
@@ -868,6 +866,8 @@ static void msm_gpio_irq_enable(struct irq_data *d)
 	struct gpio_chip *gc =3D irq_data_get_irq_chip_data(d);
 	struct msm_pinctrl *pctrl =3D gpiochip_get_data(gc);
=20
+	gpiochip_enable_irq(gc, d->hwirq);
+
 	if (d->parent_data)
 		irq_chip_enable_parent(d);
=20
@@ -885,6 +885,8 @@ static void msm_gpio_irq_disable(struct irq_data *d)
=20
 	if (!test_bit(d->hwirq, pctrl->skip_wake_irqs))
 		msm_gpio_irq_mask(d);
+
+	gpiochip_disable_irq(gc, d->hwirq);
 }
=20
 /**
@@ -958,6 +960,14 @@ static void msm_gpio_irq_ack(struct irq_data *d)
 	raw_spin_unlock_irqrestore(&pctrl->lock, flags);
 }
=20
+static void msm_gpio_irq_eoi(struct irq_data *d)
+{
+	d =3D d->parent_data;
+
+	if (d)
+		d->chip->irq_eoi(d);
+}
+
 static bool msm_gpio_needs_dual_edge_parent_workaround(struct irq_data *d,
 						       unsigned int type)
 {
@@ -1255,6 +1265,26 @@ static bool msm_gpio_needs_valid_mask(struct msm_pinct=
rl *pctrl)
 	return device_property_count_u16(pctrl->dev, "gpios") > 0;
 }
=20
+static const struct irq_chip msm_gpio_irq_chip =3D {
+	.name			=3D "msmgpio",
+	.irq_enable		=3D msm_gpio_irq_enable,
+	.irq_disable		=3D msm_gpio_irq_disable,
+	.irq_mask		=3D msm_gpio_irq_mask,
+	.irq_unmask		=3D msm_gpio_irq_unmask,
+	.irq_ack		=3D msm_gpio_irq_ack,
+	.irq_eoi		=3D msm_gpio_irq_eoi,
+	.irq_set_type		=3D msm_gpio_irq_set_type,
+	.irq_set_wake		=3D msm_gpio_irq_set_wake,
+	.irq_request_resources	=3D msm_gpio_irq_reqres,
+	.irq_release_resources	=3D msm_gpio_irq_relres,
+	.irq_set_affinity	=3D msm_gpio_irq_set_affinity,
+	.irq_set_vcpu_affinity	=3D msm_gpio_irq_set_vcpu_affinity,
+	.flags			=3D (IRQCHIP_MASK_ON_SUSPEND |
+				   IRQCHIP_SET_TYPE_MASKED |
+				   IRQCHIP_ENABLE_WAKEUP_ON_SUSPEND |
+				   IRQCHIP_IMMUTABLE),
+};
+
 static int msm_gpio_init(struct msm_pinctrl *pctrl)
 {
 	struct gpio_chip *chip;
@@ -1276,22 +1306,6 @@ static int msm_gpio_init(struct msm_pinctrl *pctrl)
 	if (msm_gpio_needs_valid_mask(pctrl))
 		chip->init_valid_mask =3D msm_gpio_init_valid_mask;
=20
-	pctrl->irq_chip.name =3D "msmgpio";
-	pctrl->irq_chip.irq_enable =3D msm_gpio_irq_enable;
-	pctrl->irq_chip.irq_disable =3D msm_gpio_irq_disable;
-	pctrl->irq_chip.irq_mask =3D msm_gpio_irq_mask;
-	pctrl->irq_chip.irq_unmask =3D msm_gpio_irq_unmask;
-	pctrl->irq_chip.irq_ack =3D msm_gpio_irq_ack;
-	pctrl->irq_chip.irq_set_type =3D msm_gpio_irq_set_type;
-	pctrl->irq_chip.irq_set_wake =3D msm_gpio_irq_set_wake;
-	pctrl->irq_chip.irq_request_resources =3D msm_gpio_irq_reqres;
-	pctrl->irq_chip.irq_release_resources =3D msm_gpio_irq_relres;
-	pctrl->irq_chip.irq_set_affinity =3D msm_gpio_irq_set_affinity;
-	pctrl->irq_chip.irq_set_vcpu_affinity =3D msm_gpio_irq_set_vcpu_affinity;
-	pctrl->irq_chip.flags =3D IRQCHIP_MASK_ON_SUSPEND |
-				IRQCHIP_SET_TYPE_MASKED |
-				IRQCHIP_ENABLE_WAKEUP_ON_SUSPEND;
-
 	np =3D of_parse_phandle(pctrl->dev->of_node, "wakeup-parent", 0);
 	if (np) {
 		chip->irq.parent_domain =3D irq_find_matching_host(np,
@@ -1300,7 +1314,6 @@ static int msm_gpio_init(struct msm_pinctrl *pctrl)
 		if (!chip->irq.parent_domain)
 			return -EPROBE_DEFER;
 		chip->irq.child_to_parent_hwirq =3D msm_gpio_wakeirq;
-		pctrl->irq_chip.irq_eoi =3D irq_chip_eoi_parent;
 		/*
 		 * Let's skip handling the GPIOs, if the parent irqchip
 		 * is handling the direct connect IRQ of the GPIO.
@@ -1313,7 +1326,7 @@ static int msm_gpio_init(struct msm_pinctrl *pctrl)
 	}
=20
 	girq =3D &chip->irq;
-	girq->chip =3D &pctrl->irq_chip;
+	gpio_irq_chip_set_chip(girq, &msm_gpio_irq_chip);
 	girq->parent_handler =3D msm_gpio_irq_handler;
 	girq->fwnode =3D pctrl->dev->fwnode;
 	girq->num_parents =3D 1;
diff --git a/include/linux/gpio/driver.h b/include/linux/gpio/driver.h
index 874aabd270c9..cb689264f3e9 100644
--- a/include/linux/gpio/driver.h
+++ b/include/linux/gpio/driver.h
@@ -588,6 +588,22 @@ void gpiochip_relres_irq(struct gpio_chip *gc, unsigned =
int offset);
 void gpiochip_disable_irq(struct gpio_chip *gc, unsigned int offset);
 void gpiochip_enable_irq(struct gpio_chip *gc, unsigned int offset);
=20
+/* irq_data versions of the above */
+int gpiochip_irq_reqres(struct irq_data *data);
+void gpiochip_irq_relres(struct irq_data *data);
+
+/* Paste this in your irq_chip structure  */
+#define	GPIOCHIP_IRQ_RESOURCE_HELPERS					\
+		.irq_request_resources  =3D gpiochip_irq_reqres,		\
+		.irq_release_resources  =3D gpiochip_irq_relres
+
+static inline void gpio_irq_chip_set_chip(struct gpio_irq_chip *girq,
+					  const struct irq_chip *chip)
+{
+	/* Yes, dropping const is ugly, but it isn't like we have a choice */
+	girq->chip =3D (struct irq_chip *)chip;
+}
+
 /* Line status inquiry for drivers */
 bool gpiochip_line_is_open_drain(struct gpio_chip *gc, unsigned int offset);
 bool gpiochip_line_is_open_source(struct gpio_chip *gc, unsigned int offset);
diff --git a/include/linux/irq.h b/include/linux/irq.h
index f92788ccdba2..505308253d23 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -569,6 +569,7 @@ struct irq_chip {
  * IRQCHIP_ENABLE_WAKEUP_ON_SUSPEND:  Invokes __enable_irq()/__disable_irq()=
 for wake irqs
  *                                    in the suspend path if they are in dis=
abled state
  * IRQCHIP_AFFINITY_PRE_STARTUP:      Default affinity update before startup
+ * IRQCHIP_IMMUTABLE:		      Don't ever change anything in this chip
  */
 enum {
 	IRQCHIP_SET_TYPE_MASKED			=3D (1 <<  0),
@@ -582,6 +583,7 @@ enum {
 	IRQCHIP_SUPPORTS_NMI			=3D (1 <<  8),
 	IRQCHIP_ENABLE_WAKEUP_ON_SUSPEND	=3D (1 <<  9),
 	IRQCHIP_AFFINITY_PRE_STARTUP		=3D (1 << 10),
+	IRQCHIP_IMMUTABLE			=3D (1 << 11),
 };
=20
 #include <linux/irqdesc.h>
diff --git a/include/linux/irqchip/arm-gic-v3.h b/include/linux/irqchip/arm-g=
ic-v3.h
index 12d91f0dedf9..728691365464 100644
--- a/include/linux/irqchip/arm-gic-v3.h
+++ b/include/linux/irqchip/arm-gic-v3.h
@@ -127,6 +127,8 @@
 #define GICR_PIDR2			GICD_PIDR2
=20
 #define GICR_CTLR_ENABLE_LPIS		(1UL << 0)
+#define GICR_CTLR_CES			(1UL << 1)
+#define GICR_CTLR_IR			(1UL << 2)
 #define GICR_CTLR_RWP			(1UL << 3)
=20
 #define GICR_TYPER_CPU_NUMBER(r)	(((r) >> 8) & 0xffff)
diff --git a/kernel/irq/affinity.c b/kernel/irq/affinity.c
index fdf170404650..d9a5c1d65a79 100644
--- a/kernel/irq/affinity.c
+++ b/kernel/irq/affinity.c
@@ -258,7 +258,7 @@ static int __irq_build_affinity_masks(unsigned int startv=
ec,
 	nodemask_t nodemsk =3D NODE_MASK_NONE;
 	struct node_vectors *node_vectors;
=20
-	if (!cpumask_weight(cpu_mask))
+	if (cpumask_empty(cpu_mask))
 		return 0;
=20
 	nodes =3D get_nodes_in_cpumask(node_to_cpumask, cpu_mask, &nodemsk);
diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index 54af0deb239b..e6b8e564b37f 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -1573,17 +1573,12 @@ static struct device *irq_get_parent_device(struct ir=
q_data *data)
 int irq_chip_pm_get(struct irq_data *data)
 {
 	struct device *dev =3D irq_get_parent_device(data);
-	int retval;
+	int retval =3D 0;
=20
-	if (IS_ENABLED(CONFIG_PM) && dev) {
-		retval =3D pm_runtime_get_sync(dev);
-		if (retval < 0) {
-			pm_runtime_put_noidle(dev);
-			return retval;
-		}
-	}
+	if (IS_ENABLED(CONFIG_PM) && dev)
+		retval =3D pm_runtime_resume_and_get(dev);
=20
-	return 0;
+	return retval;
 }
=20
 /**
diff --git a/kernel/irq/debugfs.c b/kernel/irq/debugfs.c
index 2b43f5f5033d..bc8e40cf2b65 100644
--- a/kernel/irq/debugfs.c
+++ b/kernel/irq/debugfs.c
@@ -58,6 +58,7 @@ static const struct irq_bit_descr irqchip_flags[] =3D {
 	BIT_MASK_DESCR(IRQCHIP_SUPPORTS_LEVEL_MSI),
 	BIT_MASK_DESCR(IRQCHIP_SUPPORTS_NMI),
 	BIT_MASK_DESCR(IRQCHIP_ENABLE_WAKEUP_ON_SUSPEND),
+	BIT_MASK_DESCR(IRQCHIP_IMMUTABLE),
 };
=20
 static void
diff --git a/kernel/irq/irq_sim.c b/kernel/irq/irq_sim.c
index 0cd02efa3a74..dd76323ea3fd 100644
--- a/kernel/irq/irq_sim.c
+++ b/kernel/irq/irq_sim.c
@@ -181,7 +181,7 @@ struct irq_domain *irq_domain_create_sim(struct fwnode_ha=
ndle *fwnode,
 		goto err_free_bitmap;
=20
 	work_ctx->irq_count =3D num_irqs;
-	init_irq_work(&work_ctx->work, irq_sim_handle_irq);
+	work_ctx->work =3D IRQ_WORK_INIT_HARD(irq_sim_handle_irq);
=20
 	return work_ctx->domain;
=20
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index c03f71d5ec10..f1d5a94c6c9f 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -222,11 +222,16 @@ int irq_do_set_affinity(struct irq_data *data, const st=
ruct cpumask *mask,
 {
 	struct irq_desc *desc =3D irq_data_to_desc(data);
 	struct irq_chip *chip =3D irq_data_get_irq_chip(data);
+	const struct cpumask  *prog_mask;
 	int ret;
=20
+	static DEFINE_RAW_SPINLOCK(tmp_mask_lock);
+	static struct cpumask tmp_mask;
+
 	if (!chip || !chip->irq_set_affinity)
 		return -EINVAL;
=20
+	raw_spin_lock(&tmp_mask_lock);
 	/*
 	 * If this is a managed interrupt and housekeeping is enabled on
 	 * it check whether the requested affinity mask intersects with
@@ -248,24 +253,34 @@ int irq_do_set_affinity(struct irq_data *data, const st=
ruct cpumask *mask,
 	 */
 	if (irqd_affinity_is_managed(data) &&
 	    housekeeping_enabled(HK_TYPE_MANAGED_IRQ)) {
-		const struct cpumask *hk_mask, *prog_mask;
-
-		static DEFINE_RAW_SPINLOCK(tmp_mask_lock);
-		static struct cpumask tmp_mask;
+		const struct cpumask *hk_mask;
=20
 		hk_mask =3D housekeeping_cpumask(HK_TYPE_MANAGED_IRQ);
=20
-		raw_spin_lock(&tmp_mask_lock);
 		cpumask_and(&tmp_mask, mask, hk_mask);
 		if (!cpumask_intersects(&tmp_mask, cpu_online_mask))
 			prog_mask =3D mask;
 		else
 			prog_mask =3D &tmp_mask;
-		ret =3D chip->irq_set_affinity(data, prog_mask, force);
-		raw_spin_unlock(&tmp_mask_lock);
 	} else {
-		ret =3D chip->irq_set_affinity(data, mask, force);
+		prog_mask =3D mask;
 	}
+
+	/*
+	 * Make sure we only provide online CPUs to the irqchip,
+	 * unless we are being asked to force the affinity (in which
+	 * case we do as we are told).
+	 */
+	cpumask_and(&tmp_mask, prog_mask, cpu_online_mask);
+	if (!force && !cpumask_empty(&tmp_mask))
+		ret =3D chip->irq_set_affinity(data, &tmp_mask, force);
+	else if (force)
+		ret =3D chip->irq_set_affinity(data, mask, force);
+	else
+		ret =3D -EINVAL;
+
+	raw_spin_unlock(&tmp_mask_lock);
+
 	switch (ret) {
 	case IRQ_SET_MASK_OK:
 	case IRQ_SET_MASK_OK_DONE:
diff --git a/kernel/irq/matrix.c b/kernel/irq/matrix.c
index bbfb26489aa1..1698e77645ac 100644
--- a/kernel/irq/matrix.c
+++ b/kernel/irq/matrix.c
@@ -286,7 +286,7 @@ void irq_matrix_remove_managed(struct irq_matrix *m, cons=
t struct cpumask *msk)
 int irq_matrix_alloc_managed(struct irq_matrix *m, const struct cpumask *msk,
 			     unsigned int *mapped_cpu)
 {
-	unsigned int bit, cpu, end =3D m->alloc_end;
+	unsigned int bit, cpu, end;
 	struct cpumap *cm;
=20
 	if (cpumask_empty(msk))
diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index 2bdfce5edafd..a9ee535293eb 100644
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -818,6 +818,21 @@ static int msi_init_virq(struct irq_domain *domain, int =
virq, unsigned int vflag
 		irqd_clr_can_reserve(irqd);
 		if (vflags & VIRQ_NOMASK_QUIRK)
 			irqd_set_msi_nomask_quirk(irqd);
+
+		/*
+		 * If the interrupt is managed but no CPU is available to
+		 * service it, shut it down until better times. Note that
+		 * we only do this on the !RESERVE path as x86 (the only
+		 * architecture using this flag) deals with this in a
+		 * different way by using a catch-all vector.
+		 */
+		if ((vflags & VIRQ_ACTIVATE) &&
+		    irqd_affinity_is_managed(irqd) &&
+		    !cpumask_intersects(irq_data_get_affinity_mask(irqd),
+					cpu_online_mask)) {
+			    irqd_set_managed_shutdown(irqd);
+			    return 0;
+		    }
 	}
=20
 	if (!(vflags & VIRQ_ACTIVATE))

