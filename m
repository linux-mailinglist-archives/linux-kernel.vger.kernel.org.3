Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B322B48615F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 09:24:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236546AbiAFIYD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 03:24:03 -0500
Received: from isilmar-4.linta.de ([136.243.71.142]:52488 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236505AbiAFIYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 03:24:02 -0500
X-isilmar-external: YES
Received: from light.dominikbrodowski.net (brodo.linta [10.2.0.102])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id 8162C201414
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jan 2022 08:24:00 +0000 (UTC)
Received: by light.dominikbrodowski.net (Postfix, from userid 1000)
        id 63B242129F; Thu,  6 Jan 2022 09:23:49 +0100 (CET)
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH] pcmcia: use sysfs_emit{,_at} for sysfs output
Date:   Thu,  6 Jan 2022 09:23:45 +0100
Message-Id: <20220106082345.26695-1-linux@dominikbrodowski.net>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the PCMCIA core and yenta_socket.c to use sysfs_emit or
sysfs_emit_at when providing output in sysfs.

Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 drivers/pcmcia/ds.c             | 20 +++++++++-----------
 drivers/pcmcia/rsrc_nonstatic.c |  6 +++---
 drivers/pcmcia/socket_sysfs.c   | 18 +++++++++---------
 drivers/pcmcia/yenta_socket.c   | 14 +++++++-------
 4 files changed, 28 insertions(+), 30 deletions(-)

diff --git a/drivers/pcmcia/ds.c b/drivers/pcmcia/ds.c
index 5bd1b80424e7..ace133b9f7d4 100644
--- a/drivers/pcmcia/ds.c
+++ b/drivers/pcmcia/ds.c
@@ -998,7 +998,7 @@ static int runtime_resume(struct device *dev)
 static ssize_t field##_show (struct device *dev, struct device_attribute *attr, char *buf)		\
 {									\
 	struct pcmcia_device *p_dev = to_pcmcia_dev(dev);		\
-	return p_dev->test ? sprintf(buf, format, p_dev->field) : -ENODEV; \
+	return p_dev->test ? sysfs_emit(buf, format, p_dev->field) : -ENODEV; \
 }									\
 static DEVICE_ATTR_RO(field);
 
@@ -1006,7 +1006,7 @@ static DEVICE_ATTR_RO(field);
 static ssize_t name##_show (struct device *dev, struct device_attribute *attr, char *buf)		\
 {									\
 	struct pcmcia_device *p_dev = to_pcmcia_dev(dev);		\
-	return p_dev->field ? sprintf(buf, "%s\n", p_dev->field) : -ENODEV; \
+	return p_dev->field ? sysfs_emit(buf, "%s\n", p_dev->field) : -ENODEV; \
 }									\
 static DEVICE_ATTR_RO(name);
 
@@ -1022,7 +1022,7 @@ static ssize_t function_show(struct device *dev, struct device_attribute *attr,
 			     char *buf)
 {
 	struct pcmcia_device *p_dev = to_pcmcia_dev(dev);
-	return p_dev->socket ? sprintf(buf, "0x%02x\n", p_dev->func) : -ENODEV;
+	return p_dev->socket ? sysfs_emit(buf, "0x%02x\n", p_dev->func) : -ENODEV;
 }
 static DEVICE_ATTR_RO(function);
 
@@ -1030,13 +1030,12 @@ static ssize_t resources_show(struct device *dev,
 			      struct device_attribute *attr, char *buf)
 {
 	struct pcmcia_device *p_dev = to_pcmcia_dev(dev);
-	char *str = buf;
-	int i;
+	int i, at = 0;
 
 	for (i = 0; i < PCMCIA_NUM_RESOURCES; i++)
-		str += sprintf(str, "%pr\n", p_dev->resource[i]);
+		at += sysfs_emit_at(buf, at, "%pr\n", p_dev->resource[i]);
 
-	return str - buf;
+	return at;
 }
 static DEVICE_ATTR_RO(resources);
 
@@ -1045,9 +1044,9 @@ static ssize_t pm_state_show(struct device *dev, struct device_attribute *attr,
 	struct pcmcia_device *p_dev = to_pcmcia_dev(dev);
 
 	if (p_dev->suspended)
-		return sprintf(buf, "off\n");
+		return sysfs_emit(buf, "off\n");
 	else
-		return sprintf(buf, "on\n");
+		return sysfs_emit(buf, "on\n");
 }
 
 static ssize_t pm_state_store(struct device *dev, struct device_attribute *attr,
@@ -1081,8 +1080,7 @@ static ssize_t modalias_show(struct device *dev, struct device_attribute *attr,
 		hash[i] = crc32(0, p_dev->prod_id[i],
 				strlen(p_dev->prod_id[i]));
 	}
-	return sprintf(buf, "pcmcia:m%04Xc%04Xf%02Xfn%02Xpfn%02X"
-				"pa%08Xpb%08Xpc%08Xpd%08X\n",
+	return sysfs_emit(buf, "pcmcia:m%04Xc%04Xf%02Xfn%02Xpfn%02Xpa%08Xpb%08Xpc%08Xpd%08X\n",
 				p_dev->has_manf_id ? p_dev->manf_id : 0,
 				p_dev->has_card_id ? p_dev->card_id : 0,
 				p_dev->has_func_id ? p_dev->func_id : 0,
diff --git a/drivers/pcmcia/rsrc_nonstatic.c b/drivers/pcmcia/rsrc_nonstatic.c
index 1cac52870711..6b6c578b5f92 100644
--- a/drivers/pcmcia/rsrc_nonstatic.c
+++ b/drivers/pcmcia/rsrc_nonstatic.c
@@ -1082,7 +1082,7 @@ static ssize_t show_io_db(struct device *dev,
 	for (p = data->io_db.next; p != &data->io_db; p = p->next) {
 		if (ret > (PAGE_SIZE - 10))
 			continue;
-		ret += scnprintf(&buf[ret], (PAGE_SIZE - ret - 1),
+		ret += sysfs_emit_at(buf, ret,
 				"0x%08lx - 0x%08lx\n",
 				((unsigned long) p->base),
 				((unsigned long) p->base + p->num - 1));
@@ -1139,7 +1139,7 @@ static ssize_t show_mem_db(struct device *dev,
 	     p = p->next) {
 		if (ret > (PAGE_SIZE - 10))
 			continue;
-		ret += scnprintf(&buf[ret], (PAGE_SIZE - ret - 1),
+		ret += sysfs_emit_at(buf, ret,
 				"0x%08lx - 0x%08lx\n",
 				((unsigned long) p->base),
 				((unsigned long) p->base + p->num - 1));
@@ -1148,7 +1148,7 @@ static ssize_t show_mem_db(struct device *dev,
 	for (p = data->mem_db.next; p != &data->mem_db; p = p->next) {
 		if (ret > (PAGE_SIZE - 10))
 			continue;
-		ret += scnprintf(&buf[ret], (PAGE_SIZE - ret - 1),
+		ret += sysfs_emit_at(buf, ret,
 				"0x%08lx - 0x%08lx\n",
 				((unsigned long) p->base),
 				((unsigned long) p->base + p->num - 1));
diff --git a/drivers/pcmcia/socket_sysfs.c b/drivers/pcmcia/socket_sysfs.c
index d1b220a1e1ab..c7a906664c36 100644
--- a/drivers/pcmcia/socket_sysfs.c
+++ b/drivers/pcmcia/socket_sysfs.c
@@ -38,8 +38,8 @@ static ssize_t pccard_show_type(struct device *dev, struct device_attribute *att
 	if (!(s->state & SOCKET_PRESENT))
 		return -ENODEV;
 	if (s->state & SOCKET_CARDBUS)
-		return sprintf(buf, "32-bit\n");
-	return sprintf(buf, "16-bit\n");
+		return sysfs_emit(buf, "32-bit\n");
+	return sysfs_emit(buf, "16-bit\n");
 }
 static DEVICE_ATTR(card_type, 0444, pccard_show_type, NULL);
 
@@ -51,9 +51,9 @@ static ssize_t pccard_show_voltage(struct device *dev, struct device_attribute *
 	if (!(s->state & SOCKET_PRESENT))
 		return -ENODEV;
 	if (s->socket.Vcc)
-		return sprintf(buf, "%d.%dV\n", s->socket.Vcc / 10,
+		return sysfs_emit(buf, "%d.%dV\n", s->socket.Vcc / 10,
 			       s->socket.Vcc % 10);
-	return sprintf(buf, "X.XV\n");
+	return sysfs_emit(buf, "X.XV\n");
 }
 static DEVICE_ATTR(card_voltage, 0444, pccard_show_voltage, NULL);
 
@@ -63,7 +63,7 @@ static ssize_t pccard_show_vpp(struct device *dev, struct device_attribute *attr
 	struct pcmcia_socket *s = to_socket(dev);
 	if (!(s->state & SOCKET_PRESENT))
 		return -ENODEV;
-	return sprintf(buf, "%d.%dV\n", s->socket.Vpp / 10, s->socket.Vpp % 10);
+	return sysfs_emit(buf, "%d.%dV\n", s->socket.Vpp / 10, s->socket.Vpp % 10);
 }
 static DEVICE_ATTR(card_vpp, 0444, pccard_show_vpp, NULL);
 
@@ -73,7 +73,7 @@ static ssize_t pccard_show_vcc(struct device *dev, struct device_attribute *attr
 	struct pcmcia_socket *s = to_socket(dev);
 	if (!(s->state & SOCKET_PRESENT))
 		return -ENODEV;
-	return sprintf(buf, "%d.%dV\n", s->socket.Vcc / 10, s->socket.Vcc % 10);
+	return sysfs_emit(buf, "%d.%dV\n", s->socket.Vcc / 10, s->socket.Vcc % 10);
 }
 static DEVICE_ATTR(card_vcc, 0444, pccard_show_vcc, NULL);
 
@@ -98,7 +98,7 @@ static ssize_t pccard_show_card_pm_state(struct device *dev,
 					 char *buf)
 {
 	struct pcmcia_socket *s = to_socket(dev);
-	return sprintf(buf, "%s\n", s->state & SOCKET_SUSPEND ? "off" : "on");
+	return sysfs_emit(buf, "%s\n", s->state & SOCKET_SUSPEND ? "off" : "on");
 }
 
 static ssize_t pccard_store_card_pm_state(struct device *dev,
@@ -145,7 +145,7 @@ static ssize_t pccard_show_irq_mask(struct device *dev,
 				    char *buf)
 {
 	struct pcmcia_socket *s = to_socket(dev);
-	return sprintf(buf, "0x%04x\n", s->irq_mask);
+	return sysfs_emit(buf, "0x%04x\n", s->irq_mask);
 }
 
 static ssize_t pccard_store_irq_mask(struct device *dev,
@@ -177,7 +177,7 @@ static ssize_t pccard_show_resource(struct device *dev,
 				    struct device_attribute *attr, char *buf)
 {
 	struct pcmcia_socket *s = to_socket(dev);
-	return sprintf(buf, "%s\n", s->resource_setup_done ? "yes" : "no");
+	return sysfs_emit(buf, "%s\n", s->resource_setup_done ? "yes" : "no");
 }
 
 static ssize_t pccard_store_resource(struct device *dev,
diff --git a/drivers/pcmcia/yenta_socket.c b/drivers/pcmcia/yenta_socket.c
index e7ec3ea23db9..837877daed62 100644
--- a/drivers/pcmcia/yenta_socket.c
+++ b/drivers/pcmcia/yenta_socket.c
@@ -178,16 +178,16 @@ static ssize_t show_yenta_registers(struct device *yentadev, struct device_attri
 	struct yenta_socket *socket = dev_get_drvdata(yentadev);
 	int offset = 0, i;
 
-	offset = snprintf(buf, PAGE_SIZE, "CB registers:");
+	offset = sysfs_emit(buf, "CB registers:");
 	for (i = 0; i < 0x24; i += 4) {
 		unsigned val;
 		if (!(i & 15))
-			offset += scnprintf(buf + offset, PAGE_SIZE - offset, "\n%02x:", i);
+			offset += sysfs_emit_at(buf, offset, "\n%02x:", i);
 		val = cb_readl(socket, i);
-		offset += scnprintf(buf + offset, PAGE_SIZE - offset, " %08x", val);
+		offset += sysfs_emit_at(buf, offset, " %08x", val);
 	}
 
-	offset += scnprintf(buf + offset, PAGE_SIZE - offset, "\n\nExCA registers:");
+	offset += sysfs_emit_at(buf, offset, "\n\nExCA registers:");
 	for (i = 0; i < 0x45; i++) {
 		unsigned char val;
 		if (!(i & 7)) {
@@ -195,12 +195,12 @@ static ssize_t show_yenta_registers(struct device *yentadev, struct device_attri
 				memcpy(buf + offset, " -", 2);
 				offset += 2;
 			} else
-				offset += scnprintf(buf + offset, PAGE_SIZE - offset, "\n%02x:", i);
+				offset += sysfs_emit_at(buf, offset, "\n%02x:", i);
 		}
 		val = exca_readb(socket, i);
-		offset += scnprintf(buf + offset, PAGE_SIZE - offset, " %02x", val);
+		offset += sysfs_emit_at(buf, offset, " %02x", val);
 	}
-	buf[offset++] = '\n';
+	sysfs_emit_at(buf, offset, "\n");
 	return offset;
 }
 
-- 
2.34.1

