Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C711533796
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 09:45:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242265AbiEYHpL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 03:45:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbiEYHpH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 03:45:07 -0400
Received: from m12-14.163.com (m12-14.163.com [220.181.12.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A7CBD7356D;
        Wed, 25 May 2022 00:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=fO+wi
        SAiyKS1yMdC8uyIoQTXd6l4aGIJhtZIX/WHYhc=; b=l54Uph3PmLUcHlF67q6Gt
        Z/1GowreLzAJEdIK1HdBM6f5GvLpumqmMGwD062LO4Iv5qPJK9+0QLZPw6Gbd6dG
        MMZf22VRpOGSTXHUCg9cdSsfvWyzzpqpuDFvhmNkhOJz0iRlABYA0FwAnFrx4vrp
        4YsOQlDyXn/umhhJsNN1Dw=
Received: from carlis (unknown [113.98.63.214])
        by smtp10 (Coremail) with SMTP id DsCowAD3chFo3o1iE0zTEA--.49691S2;
        Wed, 25 May 2022 15:44:41 +0800 (CST)
From:   Xuezhi Zhang <zhangxuezhi1@coolpad.com>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        llyz108@163.com, Xuezhi Zhang <zhangxuezhi1@coolpad.com>
Subject: [PATCH] scsi: scsi_transport_fc: convert sysfs snprintf to sysfs_emit
Date:   Wed, 25 May 2022 07:44:24 +0000
Message-Id: <20220525074424.108488-1-zhangxuezhi1@coolpad.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DsCowAD3chFo3o1iE0zTEA--.49691S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3GrW8KFyxXF1UuryDtFyUGFg_yoWxWw4kpF
        W3Ka45CrWvqF1rur1a9Fs0kF1rZF1xJ3y7JayxX34DuwsrtrWDCF1DCFWI9rn5GrWfG34U
        JF4qkFZ8Cw47AF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jnHUDUUUUU=
X-Originating-IP: [113.98.63.214]
Sender: llyz108@163.com
X-CM-SenderInfo: xoo16iiqy6il2tof0z/xtbBOQkMhV-PNhthYQAAsE
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following coccicheck warnings:
drivers/scsi/scsi_transport_fc.c:1962:9-17:
WARNING: use scnprintf or sprintf
drivers/scsi/scsi_transport_fc.c:1886:9-17:
WARNING: use scnprintf or sprintf
drivers/scsi/scsi_transport_fc.c:1910:9-17:
WARNING: use scnprintf or sprintf
drivers/scsi/scsi_transport_fc.c:1995:8-16:
WARNING: use scnprintf or sprintf
drivers/scsi/scsi_transport_fc.c:1299:9-17:
WARNING: use scnprintf or sprintf
drivers/scsi/scsi_transport_fc.c:1281:8-16:
WARNING: use scnprintf or sprintf
drivers/scsi/scsi_transport_fc.c:1213:10-18:
WARNING: use scnprintf or sprintf
drivers/scsi/scsi_transport_fc.c:1118:9-17:
WARNING: use scnprintf or sprintf
drivers/scsi/scsi_transport_fc.c:1660:9-17:
WARNING: use scnprintf or sprintf

Signed-off-by: Xuezhi Zhang <zhangxuezhi1@coolpad.com>
---
 drivers/scsi/scsi_transport_fc.c | 38 ++++++++++++++++----------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/scsi/scsi_transport_fc.c b/drivers/scsi/scsi_transport_fc.c
index a2524106206d..a47f6e0f8597 100644
--- a/drivers/scsi/scsi_transport_fc.c
+++ b/drivers/scsi/scsi_transport_fc.c
@@ -1115,7 +1115,7 @@ show_fc_rport_supported_classes (struct device *dev,
 {
 	struct fc_rport *rport = transport_class_to_rport(dev);
 	if (rport->supported_classes == FC_COS_UNSPECIFIED)
-		return snprintf(buf, 20, "unspecified\n");
+		return sysfs_emit(buf, "unspecified\n");
 	return get_fc_cos_names(rport->supported_classes, buf);
 }
 static FC_DEVICE_ATTR(rport, supported_classes, S_IRUGO,
@@ -1210,21 +1210,21 @@ show_fc_rport_roles (struct device *dev, struct device_attribute *attr,
 					FC_WELLKNOWN_PORTID_MASK) {
 		switch (rport->port_id & FC_WELLKNOWN_ROLE_MASK) {
 		case FC_FPORT_PORTID:
-			return snprintf(buf, 30, "Fabric Port\n");
+			return sysfs_emit(buf, "Fabric Port\n");
 		case FC_FABCTLR_PORTID:
-			return snprintf(buf, 30, "Fabric Controller\n");
+			return sysfs_emit(buf, "Fabric Controller\n");
 		case FC_DIRSRVR_PORTID:
-			return snprintf(buf, 30, "Directory Server\n");
+			return sysfs_emit(buf, "Directory Server\n");
 		case FC_TIMESRVR_PORTID:
-			return snprintf(buf, 30, "Time Server\n");
+			return sysfs_emit(buf, "Time Server\n");
 		case FC_MGMTSRVR_PORTID:
-			return snprintf(buf, 30, "Management Server\n");
+			return sysfs_emit(buf, "Management Server\n");
 		default:
-			return snprintf(buf, 30, "Unknown Fabric Entity\n");
+			return sysfs_emit(buf, "Unknown Fabric Entity\n");
 		}
 	} else {
 		if (rport->roles == FC_PORT_ROLE_UNKNOWN)
-			return snprintf(buf, 20, "unknown\n");
+			return sysfs_emit(buf, "unknown\n");
 		return get_fc_port_roles_names(rport->roles, buf);
 	}
 }
@@ -1278,7 +1278,7 @@ show_fc_rport_port_state(struct device *dev,
 	if (!name)
 		return -EINVAL;
 
-	return snprintf(buf, 20, "%s\n", name);
+	return sysfs_emit(buf, "%s\n", name);
 }
 
 static FC_DEVICE_ATTR(rport, port_state, 0444 | 0200,
@@ -1296,8 +1296,8 @@ show_fc_rport_fast_io_fail_tmo (struct device *dev,
 	struct fc_rport *rport = transport_class_to_rport(dev);
 
 	if (rport->fast_io_fail_tmo == -1)
-		return snprintf(buf, 5, "off\n");
-	return snprintf(buf, 20, "%d\n", rport->fast_io_fail_tmo);
+		return sysfs_emit(buf, "off\n");
+	return sysfs_emit(buf, "%d\n", rport->fast_io_fail_tmo);
 }
 
 static ssize_t
@@ -1341,7 +1341,7 @@ static ssize_t fc_rport_fpinstat_##name(struct device *cd,		\
 {									\
 	struct fc_rport *rport = transport_class_to_rport(cd);		\
 									\
-	return snprintf(buf, 20, "0x%llx\n", rport->fpin_stats.name);	\
+	return sysfs_emit(buf, "0x%llx\n", rport->fpin_stats.name);	\
 }									\
 static FC_DEVICE_ATTR(rport, fpin_##name, 0444, fc_rport_fpinstat_##name, NULL)
 
@@ -1657,7 +1657,7 @@ show_fc_vport_roles (struct device *dev, struct device_attribute *attr,
 	struct fc_vport *vport = transport_class_to_vport(dev);
 
 	if (vport->roles == FC_PORT_ROLE_UNKNOWN)
-		return snprintf(buf, 20, "unknown\n");
+		return sysfs_emit(buf, "unknown\n");
 	return get_fc_port_roles_names(vport->roles, buf);
 }
 static FC_DEVICE_ATTR(vport, roles, S_IRUGO, show_fc_vport_roles, NULL);
@@ -1883,7 +1883,7 @@ show_fc_host_supported_classes (struct device *dev,
 	struct Scsi_Host *shost = transport_class_to_shost(dev);
 
 	if (fc_host_supported_classes(shost) == FC_COS_UNSPECIFIED)
-		return snprintf(buf, 20, "unspecified\n");
+		return sysfs_emit(buf, "unspecified\n");
 
 	return get_fc_cos_names(fc_host_supported_classes(shost), buf);
 }
@@ -1907,7 +1907,7 @@ show_fc_host_supported_speeds (struct device *dev,
 	struct Scsi_Host *shost = transport_class_to_shost(dev);
 
 	if (fc_host_supported_speeds(shost) == FC_PORTSPEED_UNKNOWN)
-		return snprintf(buf, 20, "unknown\n");
+		return sysfs_emit(buf, "unknown\n");
 
 	return get_fc_port_speed_names(fc_host_supported_speeds(shost), buf);
 }
@@ -1959,7 +1959,7 @@ show_fc_host_speed (struct device *dev,
 		i->f->get_host_speed(shost);
 
 	if (fc_host_speed(shost) == FC_PORTSPEED_UNKNOWN)
-		return snprintf(buf, 20, "unknown\n");
+		return sysfs_emit(buf, "unknown\n");
 
 	return get_fc_port_speed_names(fc_host_speed(shost), buf);
 }
@@ -1992,7 +1992,7 @@ show_fc_private_host_tgtid_bind_type(struct device *dev,
 	name = get_fc_tgtid_bind_type_name(fc_host_tgtid_bind_type(shost));
 	if (!name)
 		return -EINVAL;
-	return snprintf(buf, FC_BINDTYPE_MAX_NAMELEN, "%s\n", name);
+	return sysfs_emit(buf, "%s\n", name);
 }
 
 #define get_list_head_entry(pos, head, member) 		\
@@ -2101,7 +2101,7 @@ fc_stat_show(const struct device *dev, char *buf, unsigned long offset)
 	if (i->f->get_fc_host_stats) {
 		stats = (i->f->get_fc_host_stats)(shost);
 		if (stats)
-			ret = snprintf(buf, 20, "0x%llx\n",
+			ret = sysfs_emit(buf, "0x%llx\n",
 			      (unsigned long long)*(u64 *)(((u8 *) stats) + offset));
 	}
 	return ret;
@@ -2160,7 +2160,7 @@ static ssize_t fc_host_fpinstat_##name(struct device *cd,		\
 	struct Scsi_Host *shost = transport_class_to_shost(cd);		\
 	struct fc_host_attrs *fc_host = shost_to_fc_host(shost);	\
 									\
-	return snprintf(buf, 20, "0x%llx\n", fc_host->fpin_stats.name);	\
+	return sysfs_emit(buf, "0x%llx\n", fc_host->fpin_stats.name);	\
 }									\
 static FC_DEVICE_ATTR(host, fpin_##name, 0444, fc_host_fpinstat_##name, NULL)
 
-- 
2.25.1

