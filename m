Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DCAE474380
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 14:28:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234410AbhLNN2y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 08:28:54 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:60648 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229902AbhLNN2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 08:28:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1639488532; x=1671024532;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=IIB5rDXBtoZRTwes/NhdX9oReKXVwSPkBaGh5bykTbw=;
  b=Z08GqIsw5Hd6mwgYWvaihrabUNcAwQ0bX65tCyl2om2+fuADdJLWInfc
   LQcYPpnJDwgg0tYMdHSHihr7Xn7TMJxe/UNQUB6sjBH0uc+csqDap3nop
   6ns5fIvtVOFut5PiRneizYKgH/WbE9A5VsDckWtdrAZmJQ6Mi4ehhFPlb
   3aAXjv94qz5rlGmmUF9nQT8YsNPky1KjE2lQiPn11zq+bcZkE6IIgu8M3
   w/aM9B6rkYGZnTLsJ5OTx8+3+asG/x1F/K6kYghGIntcBS9TaeKMtyLp2
   /Tc9HcXXyDndxKFyRlsslD9dO3sI+DgsXSHDL7/lDEve3VaUbkI96zGPW
   A==;
IronPort-SDR: KrYtveVq1UjFx2cd3UigFuhWY901OeHqD0X1Zrep7W/oje70OgXH3qcx058UEY1xjbeQXELqjI
 XdQpY52EqH4VoCFAi+eXKQZ+P5jksEx7Smll25PL7glmp0a/7Cy8W1IWnjzgnD7p13MbwuYLgl
 QJjkXf1MXYYMPVIhD/XYy8fP9dB8iLsbKyz5YCEX2Y9GOUoX2ERXGCuDT86vhEbzEdhq0xB+8H
 /nO3lNA4wZTrUtlQStMITLwvFqj74YqtHhg1IEYE5pM1etDn+6Q3Pmsp5kP2SVofXKqdnpLcMC
 ry8KQ47M/XhlvutmXcSjnDrg
X-IronPort-AV: E=Sophos;i="5.88,205,1635231600"; 
   d="scan'208";a="147177298"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 14 Dec 2021 06:28:52 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 14 Dec 2021 06:28:52 -0700
Received: from rob-dk-mpu02.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Tue, 14 Dec 2021 06:28:51 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <lee.jones@linaro.org>, <arnd@arndb.de>
CC:     <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH] mfd: syscon: allow mapping a range of addresses
Date:   Tue, 14 Dec 2021 15:31:07 +0200
Message-ID: <20211214133107.7801-1-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow the mapping of a range of addresses for syscon. This is done through
regmap_config::wr_table, regmap_config::rd_table. Previously, only one
range could have been allocated to a syscon via
regmap_config::max_register. The code is needed for SAMA7G5 whose reset
controller contains a register (at offset 0xE001D0E4, see below) that is
used to control the USB PHYs but that register is not located continuously
in reset controller address space, as follows:

Controller's name    Memory space    Offset
      ...                ...           ...
                    +------------+  0xE001D000
Reset controller    |            |
                    +------------+  0xE001D010
Shutdown controller |            |
                    +------------+  0xE001D020
RTT controller      |            |
                    +------------+  0xE001D050
      ...                ...           ...
                    +------------+  0xE001D0E4
Reset controller    |            |
                    +------------+  0xE001D0E8
      ...                ...           ...

To control the PHYs the proper syscon is retrieved from proper driver.
With previous approach only the first range passed though device tree
was taken into account by syscon. With the code in this patch the
following DT bindings:

reset_controller: rstc@e001d000 {
        compatible = "microchip,sama7g5-rstc",
                     "microchip,sam9x60-rstc", "syscon";
        #address-cells = <1>;
        #size-cells = <1>;
        reg = <0xe001d000 0x8>,
              <0xe001d0e4 0x4>;
        clocks = <&clk32k 0>;
};

Are translated into a syscon regmap with:
- allowed ranges: [0x0, 0xC) u [0xE4, 0xE8)
- invalid ranges: [0xC, 0xE0]

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/mfd/syscon.c | 158 +++++++++++++++++++++++++++++++++++++++----
 1 file changed, 143 insertions(+), 15 deletions(-)

diff --git a/drivers/mfd/syscon.c b/drivers/mfd/syscon.c
index 191fdb87c424..fe80e6150d95 100644
--- a/drivers/mfd/syscon.c
+++ b/drivers/mfd/syscon.c
@@ -20,9 +20,36 @@
 #include <linux/platform_data/syscon.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
+#include <linux/types.h>
 #include <linux/mfd/syscon.h>
 #include <linux/slab.h>
 
+#define syscon_alloc(_dev, args...) ({					\
+	void *_ptr;							\
+	if (_dev)							\
+		_ptr = devm_kzalloc((_dev), args);			\
+	else								\
+		_ptr = kzalloc(args);					\
+	(_ptr);								\
+})
+
+#define syscon_get_resource(_pdev, _np, _idx, _res) ({			\
+	int _ret = -EINVAL;						\
+	if (_pdev) {							\
+		struct resource *_r;					\
+		_r = platform_get_resource((_pdev), IORESOURCE_MEM, (_idx));\
+		if (!_r) {						\
+			_ret = -ENOMEM;					\
+		} else {						\
+			(_res) = *_r;					\
+			_ret = 0;					\
+		}							\
+	} else if (_np) {						\
+		_ret = of_address_to_resource((_np), (_idx), &(_res));	\
+	}								\
+	(_ret);								\
+})
+
 static struct platform_driver syscon_driver;
 
 static DEFINE_SPINLOCK(syscon_list_slock);
@@ -40,14 +67,93 @@ static const struct regmap_config syscon_regmap_config = {
 	.reg_stride = 4,
 };
 
+static const struct regmap_access_table *
+syscon_prepare_regmap_access_table(struct platform_device *pdev,
+				   struct device_node *np, u32 reg_io_width,
+				   int entries)
+{
+	struct regmap_access_table *at;
+	struct regmap_range *yes_ranges, *no_ranges = NULL;
+	struct device *dev = pdev ? &pdev->dev : NULL;
+	struct resource res;
+	resource_size_t base_offset, offset;
+	int i, ret;
+
+	/* Allocate memory for access table. */
+	at = syscon_alloc(dev, sizeof(*at), GFP_KERNEL);
+	if (!at)
+		return ERR_PTR(-ENOMEM);
+
+	/* Allocate memory for allowed ranges. */
+	yes_ranges = syscon_alloc(dev, entries * sizeof(*yes_ranges),
+				  GFP_KERNEL);
+	if (!yes_ranges) {
+		ret = -ENOMEM;
+		goto free;
+	}
+
+	/* Allocate memory for invalid ranges. */
+	if (entries > 1) {
+		no_ranges = syscon_alloc(dev,
+					 (entries - 1) * sizeof(*no_ranges),
+					 GFP_KERNEL);
+		if (!no_ranges) {
+			ret = -ENOMEM;
+			goto free;
+		}
+	}
+
+	/* Populate allowed and invalid ranges. */
+	ret = syscon_get_resource(pdev, np, 0, res);
+	if (ret)
+		goto free;
+
+	base_offset = res.start;
+	yes_ranges[0].range_max = resource_size(&res) - reg_io_width;
+	if (entries > 1)
+		no_ranges[0].range_min = resource_size(&res);
+
+	for (i = 1; i < entries; i++) {
+		ret = syscon_get_resource(pdev, np, i, res);
+		if (ret)
+			goto free;
+
+		offset = res.start - base_offset;
+		yes_ranges[i].range_min = offset;
+		yes_ranges[i].range_max = offset + resource_size(&res) -
+					  reg_io_width;
+		if (i != entries - 1)
+			no_ranges[i].range_min = offset + resource_size(&res);
+		no_ranges[i - 1].range_max = offset - reg_io_width;
+	}
+
+	/* Store them to access table. */
+	at->yes_ranges = yes_ranges;
+	at->n_yes_ranges = entries;
+	at->no_ranges = no_ranges;
+	at->n_no_ranges = entries > 1 ? entries - 1 : 0;
+
+	return at;
+
+free:
+	if (!dev) {
+		kfree(no_ranges);
+		kfree(yes_ranges);
+		kfree(at);
+	}
+
+	return ERR_PTR(ret);
+}
+
 static struct syscon *of_syscon_register(struct device_node *np, bool check_clk)
 {
 	struct clk *clk;
 	struct syscon *syscon;
 	struct regmap *regmap;
 	void __iomem *base;
+	const struct regmap_access_table *at;
 	u32 reg_io_width;
-	int ret;
+	int ret, n_res = 0;
 	struct regmap_config syscon_config = syscon_regmap_config;
 	struct resource res;
 
@@ -55,11 +161,29 @@ static struct syscon *of_syscon_register(struct device_node *np, bool check_clk)
 	if (!syscon)
 		return ERR_PTR(-ENOMEM);
 
-	if (of_address_to_resource(np, 0, &res)) {
+	/* Count the number of resources. */
+	while (of_address_to_resource(np, n_res, &res) == 0)
+		n_res++;
+	if (!n_res) {
 		ret = -ENOMEM;
 		goto err_map;
 	}
 
+	/*
+	 * search for reg-io-width property in DT. If it is not provided,
+	 * default to 4 bytes. regmap_init_mmio will return an error if values
+	 * are invalid so there is no need to check them here.
+	 */
+	ret = of_property_read_u32(np, "reg-io-width", &reg_io_width);
+	if (ret)
+		reg_io_width = 4;
+
+	at = syscon_prepare_regmap_access_table(NULL, np, reg_io_width, n_res);
+	if (IS_ERR(at)) {
+		ret = PTR_ERR(at);
+		goto err_map;
+	}
+
 	base = of_iomap(np, 0);
 	if (!base) {
 		ret = -ENOMEM;
@@ -74,15 +198,6 @@ static struct syscon *of_syscon_register(struct device_node *np, bool check_clk)
 	else if (of_property_read_bool(np, "native-endian"))
 		syscon_config.val_format_endian = REGMAP_ENDIAN_NATIVE;
 
-	/*
-	 * search for reg-io-width property in DT. If it is not provided,
-	 * default to 4 bytes. regmap_init_mmio will return an error if values
-	 * are invalid so there is no need to check them here.
-	 */
-	ret = of_property_read_u32(np, "reg-io-width", &reg_io_width);
-	if (ret)
-		reg_io_width = 4;
-
 	ret = of_hwspin_lock_get_id(np, 0);
 	if (ret > 0 || (IS_ENABLED(CONFIG_HWSPINLOCK) && ret == 0)) {
 		syscon_config.use_hwlock = true;
@@ -105,7 +220,8 @@ static struct syscon *of_syscon_register(struct device_node *np, bool check_clk)
 				       (u64)res.start);
 	syscon_config.reg_stride = reg_io_width;
 	syscon_config.val_bits = reg_io_width * 8;
-	syscon_config.max_register = resource_size(&res) - reg_io_width;
+	syscon_config.wr_table = at;
+	syscon_config.rd_table = at;
 
 	regmap = regmap_init_mmio(NULL, base, &syscon_config);
 	kfree(syscon_config.name);
@@ -147,6 +263,9 @@ static struct syscon *of_syscon_register(struct device_node *np, bool check_clk)
 	iounmap(base);
 err_map:
 	kfree(syscon);
+	kfree(at->no_ranges);
+	kfree(at->yes_ranges);
+	kfree(at);
 	return ERR_PTR(ret);
 }
 
@@ -279,22 +398,31 @@ static int syscon_probe(struct platform_device *pdev)
 	struct syscon_platform_data *pdata = dev_get_platdata(dev);
 	struct syscon *syscon;
 	struct regmap_config syscon_config = syscon_regmap_config;
+	const struct regmap_access_table *at;
 	struct resource *res;
 	void __iomem *base;
+	int n_res = 0;
 
 	syscon = devm_kzalloc(dev, sizeof(*syscon), GFP_KERNEL);
 	if (!syscon)
 		return -ENOMEM;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res)
+	/* Count the number of resources. */
+	while (platform_get_resource(pdev, IORESOURCE_MEM, n_res))
+		n_res++;
+	if (!n_res)
 		return -ENOENT;
 
 	base = devm_ioremap(dev, res->start, resource_size(res));
 	if (!base)
 		return -ENOMEM;
 
-	syscon_config.max_register = resource_size(res) - 4;
+	at = syscon_prepare_regmap_access_table(pdev, NULL, 4, n_res);
+	if (IS_ERR(at))
+		return PTR_ERR(at);
+
+	syscon_config.wr_table = at;
+	syscon_config.rd_table = at;
 	if (pdata)
 		syscon_config.name = pdata->label;
 	syscon->regmap = devm_regmap_init_mmio(dev, base, &syscon_config);
-- 
2.32.0

