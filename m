Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8445059C3E9
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 18:19:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236257AbiHVQSO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 12:18:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234679AbiHVQSK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 12:18:10 -0400
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 328953AE62;
        Mon, 22 Aug 2022 09:18:07 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id E10B74C248F;
        Mon, 22 Aug 2022 16:18:06 +0000 (UTC)
Received: from pdx1-sub0-mail-a277.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 208124C30AB;
        Mon, 22 Aug 2022 16:18:06 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1661185086; a=rsa-sha256;
        cv=none;
        b=he+6pfStdmUtiqfFr7MpsEEKqlodSKxXS27hOGjoIxEm1s0DdiWXMw9ZOg5M7eMBWIm4KV
        nEDhKJcEZrBO6MlzLBr1dvSKlzqSpIauxILzGKq9xB7V2AiquGDh+eqKtV+FmFllMx9uJH
        MI1djFbYXbAkMy+ai8Or4KEx5QLrY+3xLKGJ4Hx7gKju6mPw5RdPkTjOJ3zfv7XVm8G6uo
        8yq49ISAU+P2/xE9QwR4Q6aXeTj3GOtm+E6MYza85YGf7gVkxFArupPUFFYfGh2t3JzAbT
        Pp3qxxwyu/m9yEI4lIUSb17ygoSXUWl5hRnjlIYJpOq2/RErmdofGxuL/wgd+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1661185086;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=6WTVl+O0uOXo5Sob6hcZzuOu9eJCgnmbOZgt8cwx8c4=;
        b=mdghzveEMKbiCVY3D4osZG9FXyryXTONDjhm3U2a4clCvjAWR9a01Xvnp0VqokAwwfypfq
        AUqB9Baksd5Wc/PtwYYd91s+O83pZooOr1QWJ26o8zPkb82uJTNwjuDFvSBEHKbZtd1+vC
        GRMjn2HdsFYEhqWQBtrDL/gmLixFIYaVvo2eUHFoU5D+AigoC6bK/3MF6LPTcqk1cBhEgr
        axgP3mIEpMMxkOUo1lekNb8Tom96uGlD+5wGecbImS9YOgC9t6HVHE0H5dE5acwuqJm7kP
        dNHwlSNkq+GujL8EwdPw9aDkJ+1vVyliEjruOhUp+MIE0f29+hWdPBuc2/oXxg==
ARC-Authentication-Results: i=1;
        rspamd-79945fd77c-k4h86;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Decisive-Attack: 5bf7aeac017f5eb8_1661185086491_4271913256
X-MC-Loop-Signature: 1661185086491:3361885017
X-MC-Ingress-Time: 1661185086491
Received: from pdx1-sub0-mail-a277.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.110.28.247 (trex/6.7.1);
        Mon, 22 Aug 2022 16:18:06 +0000
Received: from offworld (unknown [104.36.31.106])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a277.dreamhost.com (Postfix) with ESMTPSA id 4MBHb10qYWz2m;
        Mon, 22 Aug 2022 09:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1661185085;
        bh=6WTVl+O0uOXo5Sob6hcZzuOu9eJCgnmbOZgt8cwx8c4=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=IjeBNlAdvNsiUgUNnyuOGYPz/hn8cBrst79pooavCeMKw4M7B8CUOV957izl1hpSO
         9AbQjYdX128EIQ666RHUEF/6auwXEPei37PdCeFEm7ju+IrIlE4O1E/xDCj9IFgnpc
         83r8y+r4tF13YnZ1ZJgJJ4NSl/KpWFpGR3R2sbL9JBgZhrClS48yInWNLckQE9/Gev
         Wj7bMiTzUMpYWcBMtB1TVptbrF0qknXsA8OIu3Af9ICpSUz1evWleZLjZmWz+czZTS
         wt+vbaguInNMV6vJJyKiUG2w+8isqwbpQI7kkZiC5hlBazD8VqS9hEr6bSosVVQmcs
         G+4BJ4ZLlfh8g==
Date:   Mon, 22 Aug 2022 09:18:02 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     ira.weiny@intel.com
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        a.manzanares@samsung.com, linux-kernel@vger.kernel.org,
        linux-cxl@vger.kernel.org
Subject: Re: [RFC PATCH 0/9] CXL: Read and clear event logs
Message-ID: <20220822161802.h47v7yfrqufeltqt@offworld>
References: <20220813053243.757363-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20220813053243.757363-1-ira.weiny@intel.com>
User-Agent: NeoMutt/20220429
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Aug 2022, ira.weiny@intel.com wrote:

>From: Ira Weiny <ira.weiny@intel.com>
>
>Event records inform the OS of various device events.  Events are not needed
>for any kernel operation but various user level software will want to track
>events.
>
>Add event reporting through the trace event mechanism.  On driver load read and
>clear all device events.
>
>Normally interrupts will trigger new events to be reported as they occur.
>Because the interrupt code is still being worked on this series provides a
>cxl-test mechanism to create a series of events and trigger the reporting of
>those events.

Where is this irq code being worked on? I've asked about this for async mbox
commands, and Jonathan has also posted some code for the PMU implementation.

Could we not just start with an initial MSI/MSI-X support? Then gradually
interested users can be added? So each "feature" would need to do implement
it's "get message number" and to install the isr just do the standard:

      irq = pci_irq_vector(pdev, num);
      irq_name = devm_kasprintf(dev, GFP_KERNEL, "%s_%s\n", dev_name(dev),
			       cxl_irq_cap_table[feature].name);
      rc = devm_request_irq(dev, irq, isr_fn, IRQF_SHARED, irq_name, info);

The only complexity I see for this is to know the number of vectors to request
apriori, for which we'd have to get the larges value of all CXL features that
can support interrupts. Something like the following? One thing I have not
considered in this is the DOE stuff.

Thanks,
Davidlohr

------
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 88e3a8e54b6a..b334d2f497c1 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -245,6 +245,8 @@ struct cxl_dev_state {
	resource_size_t component_reg_phys;
	u64 serial;

+	int irq_type; /* MSI-X, MSI */
+
	struct xarray doe_mbs;

	int (*mbox_send)(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd);
diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
index eec597dbe763..95f4b91f43b1 100644
--- a/drivers/cxl/cxlpci.h
+++ b/drivers/cxl/cxlpci.h
@@ -53,15 +53,6 @@
  #define	    CXL_DVSEC_REG_LOCATOR_BLOCK_ID_MASK			GENMASK(15, 8)
  #define     CXL_DVSEC_REG_LOCATOR_BLOCK_OFF_LOW_MASK		GENMASK(31, 16)

-/* Register Block Identifier (RBI) */
-enum cxl_regloc_type {
-	CXL_REGLOC_RBI_EMPTY = 0,
-	CXL_REGLOC_RBI_COMPONENT,
-	CXL_REGLOC_RBI_VIRT,
-	CXL_REGLOC_RBI_MEMDEV,
-	CXL_REGLOC_RBI_TYPES
-};
-
  static inline resource_size_t cxl_regmap_to_base(struct pci_dev *pdev,
						 struct cxl_register_map *map)
  {
@@ -75,4 +66,44 @@ int devm_cxl_port_enumerate_dports(struct cxl_port *port);
  struct cxl_dev_state;
  int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm);
  void read_cdat_data(struct cxl_port *port);
+
+#define CXL_IRQ_CAPABILITY_TABLE				\
+	C(ISOLATION, "isolation", NULL),			\
+	C(PMU, "pmu_overflow", NULL), /* per pmu instance */	\
+	C(MBOX, "mailbox", NULL), /* primary-only */		\
+	C(EVENT, "event", NULL),
+
+#undef C
+#define C(a, b, c) CXL_IRQ_CAPABILITY_##a
+enum  { CXL_IRQ_CAPABILITY_TABLE };
+#undef C
+#define C(a, b, c) { b, c }
+/**
+ * struct cxl_irq_cap - CXL feature that is capable of receiving MSI/MSI-X irqs.
+ *
+ * @name: Name of the device generating this interrupt.
+ * @get_max_msgnum: Get the feature's largest interrupt message number. In cases
+ *                  where there is only one instance it also indicates which
+ *                  MSI/MSI-X vector is used for the interrupt message generated
+ *                  in association with the feature. If the feature does not
+ *                  have the Interrupt Supported bit set, then return -1.
+ */
+struct cxl_irq_cap {
+	const char *name;
+	int (*get_max_msgnum)(struct cxl_dev_state *cxlds);
+};
+
+static const
+struct cxl_irq_cap cxl_irq_cap_table[] = { CXL_IRQ_CAPABILITY_TABLE };
+#undef C
+
+/* Register Block Identifier (RBI) */
+enum cxl_regloc_type {
+	CXL_REGLOC_RBI_EMPTY = 0,
+	CXL_REGLOC_RBI_COMPONENT,
+	CXL_REGLOC_RBI_VIRT,
+	CXL_REGLOC_RBI_MEMDEV,
+	CXL_REGLOC_RBI_TYPES
+};
+
  #endif /* __CXL_PCI_H__ */
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index faeb5d9d7a7a..c0fe78e0559b 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -387,6 +387,52 @@ static int cxl_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
	return rc;
  }

+static void cxl_pci_free_irq_vectors(void *data)
+{
+	pci_free_irq_vectors(data);
+}
+
+static int cxl_pci_alloc_irq_vectors(struct cxl_dev_state *cxlds)
+{
+	struct device *dev = cxlds->dev;
+	struct pci_dev *pdev = to_pci_dev(dev);
+	int rc, i, vectors = -1;
+
+	for (i = 0; i < ARRAY_SIZE(cxl_irq_cap_table); i++) {
+		int irq;
+
+		if (!cxl_irq_cap_table[i].get_max_msgnum)
+			continue;
+
+		irq = cxl_irq_cap_table[i].get_max_msgnum(cxlds);
+		vectors = max_t(int, irq, vectors);
+	}
+
+	if (vectors == -1)
+		return -EINVAL; /* no irq support whatsoever */
+
+	vectors++;
+	rc = pci_alloc_irq_vectors(pdev, vectors, vectors, PCI_IRQ_MSIX);
+	if (rc < 0) {
+		rc = pci_alloc_irq_vectors(pdev, vectors, vectors, PCI_IRQ_MSI);
+		if (rc < 0)
+			return rc;
+
+		cxlds->irq_type = PCI_IRQ_MSI;
+	} else {
+		cxlds->irq_type = PCI_IRQ_MSIX;
+	}
+
+	if (rc != vectors) {
+		pci_err(pdev, "Not enough interrupts; use polling where supported\n");
+		/* Some got allocated; clean them up */
+		cxl_pci_free_irq_vectors(pdev);
+		return -ENOSPC;
+	}
+
+	return devm_add_action_or_reset(dev, cxl_pci_free_irq_vectors, pdev);
+}
+
  static void cxl_pci_destroy_doe(void *mbs)
  {
	xa_destroy(mbs);
@@ -476,6 +522,9 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)

	cxlds->component_reg_phys = cxl_regmap_to_base(pdev, &map);

+	if (cxl_pci_alloc_irq_vectors(cxlds))
+		cxlds->irq_type = 0;
+
	devm_cxl_pci_create_doe(cxlds);

	rc = cxl_pci_setup_mailbox(cxlds);
