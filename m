Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83DAB522DD1
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 10:03:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243289AbiEKIDK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 04:03:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241805AbiEKIDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 04:03:04 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC5608B08C
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 01:03:02 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id q23so1789507wra.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 01:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=GcjkZzrLn6gMWk4BhtvbTNa6RAyAFLU8Gib10fMIL6M=;
        b=UFsCqPurNA77DAQgdLeQK8XeRTaY48TIY6s55owkQ/HgvOvfVLRQqmVns5XkEwBZm6
         56SK0SRGUPqyFSHm6kzFsqS/WCSavHeFIJcunmiB8T6YQVsHAP976fuV0RDx1fancQkE
         pSz4Dy+7QjawQo5E9RZCzBbjfCovqAgf6SQnM4htoYjHzRGklIi+IRKyQ3Vq3sfQUUFj
         Ob5BtPJ9es4c7J1OqHqdFMkzvbg3vandDzGIcfssTWeB3TYQ7BdlOt4vC2SQ69owYueh
         YcwkeL249xYiu+DEr2CGR6yORYiafhfJr4LYTW0bAPJZE22e2aHtcWk3YZKi6NGCe6bD
         pUow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=GcjkZzrLn6gMWk4BhtvbTNa6RAyAFLU8Gib10fMIL6M=;
        b=ThWHTi7+xrZddH07PbteIcmLpYz9NoNeyE6oUymr9w1Z4Ylb+Nn4NGnE920HZpGFu8
         /P3808oF/9P86QpibvZCVLH7beF8WmpCJI0UOi2qe6Jb+ecXikA3LW72j4xdS8/HO+B0
         MEFWBoxkJ1VeQyQ6UYhlCzjFOZ6nvyaoQ0pEcVnmUvzDlpK58ud1ED+iNuwsDvcgWBBP
         5aMhQLZpm8cVcy+LxKn3UcgLWFaSojR4IVq/VV/2M2IBZZFIDsLgq6lXf+uFGc0ycyvT
         1P2Msp0PUF9PAZgxLZa8/kH0xHc7zg2l4ggLUaNE1m0Vxz/QxqyHaL4pCnVlhy1OeW8z
         FyPw==
X-Gm-Message-State: AOAM532/sLjPN8OmVNrlOIXPt3oUgyfswgx9nc7k4xbnnB/n7vPSr/PD
        1hcMZesNndKz7ugJeuWC3qUDBA==
X-Google-Smtp-Source: ABdhPJz141wwvjEmkFZHdaUgpw9RZwbK3CfA9t7e/8C9BiOzO9p9S/blepjTYOpKbso5uRqwI3xJxQ==
X-Received: by 2002:a05:6000:1c09:b0:20c:b986:e593 with SMTP id ba9-20020a0560001c0900b0020cb986e593mr16089270wrb.170.1652256181310;
        Wed, 11 May 2022 01:03:01 -0700 (PDT)
Received: from Red ([2a01:cb1d:3d5:a100:264b:feff:fe03:2806])
        by smtp.googlemail.com with ESMTPSA id z15-20020a05600c220f00b00394538d039esm4602915wml.6.2022.05.11.01.02.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 01:03:00 -0700 (PDT)
Date:   Wed, 11 May 2022 10:02:58 +0200
From:   LABBE Corentin <clabbe@baylibre.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Andrew Lunn <andrew@lunn.ch>, alexandre.torgue@foss.st.com,
        calvin.johnson@oss.nxp.com, davem@davemloft.net,
        edumazet@google.com, hkallweit1@gmail.com,
        jernej.skrabec@gmail.com, joabreu@synopsys.com,
        krzysztof.kozlowski+dt@linaro.org, kuba@kernel.org,
        lgirdwood@gmail.com, linux@armlinux.org.uk, pabeni@redhat.com,
        peppe.cavallaro@st.com, robh+dt@kernel.org, samuel@sholland.org,
        wens@csie.org, netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev
Subject: Re: [PATCH 3/6] dt-bindings: net: Add documentation for phy-supply
Message-ID: <YnttssHyCf8PJJev@Red>
References: <20220509074857.195302-1-clabbe@baylibre.com>
 <20220509074857.195302-4-clabbe@baylibre.com>
 <YnkGV8DyTlCuT92R@lunn.ch>
 <YnkWl+xYCX8r9DE7@Red>
 <Ynk7L07VH/RFVzl6@lunn.ch>
 <Ynk9ccoVh32Deg45@sirena.org.uk>
 <YnlDbbegQ1IbbaHy@lunn.ch>
 <YnlHwpiow9Flgzas@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YnlHwpiow9Flgzas@sirena.org.uk>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Mon, May 09, 2022 at 05:56:34PM +0100, Mark Brown a écrit :
> On Mon, May 09, 2022 at 06:38:05PM +0200, Andrew Lunn wrote:
> 
> > So we have a collection of regulators, varying in numbers between
> > different PHYs, with different vendor names and purposes. In general,
> > they all should be turned on. Yet we want them named so it is clear
> > what is going on.
> 
> > Is there a generic solution here so that the phylib core can somehow
> > enumerate them and turn them on, without actually knowing what they
> > are called because they have vendor specific names in order to be
> > clear what they are?
> 
> > There must be a solution to this, phylib cannot be the first subsystem
> > to have this requirement, so if you could point to an example, that
> > would be great.
> 
> No, it's not really come up much before - generally things with
> regulator control that have generic drivers tend not to be sophisticated
> enough to have more than one supply, or to be on an enumerable bus where
> the power is part of the bus specification so have the power specified
> as part of the bus.  You'd need to extend the regulator bindings to
> support parallel array of phandles and array of names properties like
> clocks have as an option like you were asking for, which would doubtless
> be fun for validation but is probably the thing here.

Does you mean something like this:
diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 1e54a833f2cf..404f5b874b59 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -351,6 +351,32 @@ static void regulator_lock_dependent(struct regulator_dev *rdev,
 	mutex_unlock(&regulator_list_mutex);
 }
 
+/**
+ * of_get_regulator_from_list - get a regulator device node based on supply name
+ * from a DT regulators list
+ * @dev: Device pointer for the consumer (of regulator) device
+ * @supply: regulator supply name
+ *
+ * Extract the regulator device node corresponding to the supply name.
+ * returns the device node corresponding to the regulator if found, else
+ * returns NULL.
+ */
+static struct device_node *of_get_regulator_from_list(struct device *dev,
+						      struct device_node *np,
+						      const char *supply)
+{
+	int index, ret;
+	struct of_phandle_args regspec;
+
+	index = of_property_match_string(np, "regulator-names", supply);
+	if (index >= 0) {
+		ret = of_parse_phandle_with_args(np, "regulators", NULL, index, &regspec);
+		if (ret == 0)
+			return regspec.np;
+	}
+	return NULL;
+}
+
 /**
  * of_get_child_regulator - get a child regulator device node
  * based on supply name
@@ -362,17 +388,23 @@ static void regulator_lock_dependent(struct regulator_dev *rdev,
  * returns the device node corresponding to the regulator if found, else
  * returns NULL.
  */
-static struct device_node *of_get_child_regulator(struct device_node *parent,
-						  const char *prop_name)
+static struct device_node *of_get_child_regulator(struct device *dev,
+						  struct device_node *parent,
+						  const char *supply)
 {
 	struct device_node *regnode = NULL;
 	struct device_node *child = NULL;
+	char prop_name[64]; /* 64 is max size of property name */
 
+	snprintf(prop_name, 64, "%s-supply", supply);
 	for_each_child_of_node(parent, child) {
+		regnode = of_get_regulator_from_list(dev, child, supply);
+		if (regnode)
+			return regnode;
 		regnode = of_parse_phandle(child, prop_name, 0);
 
 		if (!regnode) {
-			regnode = of_get_child_regulator(child, prop_name);
+			regnode = of_get_child_regulator(dev, child, prop_name);
 			if (regnode)
 				goto err_node_put;
 		} else {
@@ -401,12 +433,15 @@ static struct device_node *of_get_regulator(struct device *dev, const char *supp
 	char prop_name[64]; /* 64 is max size of property name */
 
 	dev_dbg(dev, "Looking up %s-supply from device tree\n", supply);
+	regnode = of_get_regulator_from_list(dev, dev->of_node, supply);
+	if (regnode)
+		return regnode;
 
 	snprintf(prop_name, 64, "%s-supply", supply);
 	regnode = of_parse_phandle(dev->of_node, prop_name, 0);
 
 	if (!regnode) {
-		regnode = of_get_child_regulator(dev->of_node, prop_name);
+		regnode = of_get_child_regulator(dev, dev->of_node, supply);
 		if (regnode)
 			return regnode;
 

And then for our case, a regulator_get_bulk will be needed.
Does I well understood what you mean ?
