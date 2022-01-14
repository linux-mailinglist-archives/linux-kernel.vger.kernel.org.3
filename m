Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32C2948EEF8
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 18:05:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243719AbiANRFH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 12:05:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:52598 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243708AbiANRFF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 12:05:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642179904;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=NVYKjhnkLV/svSI6KvkwlE+spjnGNnsoSLgbeYPEv9I=;
        b=WcUWiH9rqnwhjzgix4WYjb6iQgmuNUtVEMNk6HH/BJes0jTxa6XpNFwcFxh9CoH4bGMyJq
        uEJpI9XvWlHq1fQigzB6YJ+naS+aFNZ+A+CKveCKkCN14NiVILC7Fl1iPRxGz4QWRrqLWl
        sn9MWc+psJGFO4MmLMmYz8WtfsIizxo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-287-06Hw7hyYMZSdqkBAsC7yAA-1; Fri, 14 Jan 2022 12:05:03 -0500
X-MC-Unique: 06Hw7hyYMZSdqkBAsC7yAA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C96ED18B62A8;
        Fri, 14 Jan 2022 17:05:01 +0000 (UTC)
Received: from jmeneghi.bos.com (unknown [10.22.17.136])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F25825B2EC;
        Fri, 14 Jan 2022 17:05:00 +0000 (UTC)
From:   John Meneghini <jmeneghi@redhat.com>
To:     linux-scsi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        GR-QLogic-Storage-Upstream@marvell.com, mlombard@redhat.com,
        skashyap@marvell.com
Subject: [PATCH V2] scsi: bnx2fc: flush destroy_work queue before calling bnx2fc_interface_put
Date:   Fri, 14 Jan 2022 12:04:25 -0500
Message-Id: <20220114170424.871391-1-jmeneghi@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  The bnx2fc_destroy functions are removing the interface before calling
  destroy_work. This results multiple WARNings from sysfs_remove_group
  as the controller rport device attributes are removed to early.

  Replace the fcoe_port's destroy_work queue.  It's not needed.

  The problem is easily reproducible with the following steps.

  Example:

    $ dmesg -w &
    $ systemctl enable --now fcoe
    $ fipvlan -s -c ens2f1
    $ fcoeadm -d ens2f1.802
    [  583.464488] host2: libfc: Link down on port (7500a1)
    [  583.472651] bnx2fc: 7500a1 - rport not created Yet!!
    [  583.490468] ------------[ cut here ]------------
    [  583.538725] sysfs group 'power' not found for kobject 'rport-2:0-0'
    [  583.568814] WARNING: CPU: 3 PID: 192 at fs/sysfs/group.c:279 sysfs_remove_group+0x6f/0x80
    [  583.607130] Modules linked in: dm_service_time 8021q garp mrp stp llc bnx2fc cnic uio rpcsec_gss_krb5 auth_rpcgss nfsv4 ...
    [  583.942994] CPU: 3 PID: 192 Comm: kworker/3:2 Kdump: loaded Not tainted 5.14.0-39.el9.x86_64 #1
    [  583.984105] Hardware name: HP ProLiant DL120 G7, BIOS J01 07/01/2013
    [  584.016535] Workqueue: fc_wq_2 fc_rport_final_delete [scsi_transport_fc]
    [  584.050691] RIP: 0010:sysfs_remove_group+0x6f/0x80
    [  584.074725] Code: ff 5b 48 89 ef 5d 41 5c e9 ee c0 ff ff 48 89 ef e8 f6 b8 ff ff eb d1 49 8b 14 24 48 8b 33 48 c7 c7 ...
    [  584.162586] RSP: 0018:ffffb567c15afdc0 EFLAGS: 00010282
    [  584.188225] RAX: 0000000000000000 RBX: ffffffff8eec4220 RCX: 0000000000000000
    [  584.221053] RDX: ffff8c1586ce84c0 RSI: ffff8c1586cd7cc0 RDI: ffff8c1586cd7cc0
    [  584.255089] RBP: 0000000000000000 R08: 0000000000000000 R09: ffffb567c15afc00
    [  584.287954] R10: ffffb567c15afbf8 R11: ffffffff8fbe7f28 R12: ffff8c1486326400
    [  584.322356] R13: ffff8c1486326480 R14: ffff8c1483a4a000 R15: 0000000000000004
    [  584.355379] FS:  0000000000000000(0000) GS:ffff8c1586cc0000(0000) knlGS:0000000000000000
    [  584.394419] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
    [  584.421123] CR2: 00007fe95a6f7840 CR3: 0000000107674002 CR4: 00000000000606e0
    [  584.454888] Call Trace:
    [  584.466108]  device_del+0xb2/0x3e0
    [  584.481701]  device_unregister+0x13/0x60
    [  584.501306]  bsg_unregister_queue+0x5b/0x80
    [  584.522029]  bsg_remove_queue+0x1c/0x40
    [  584.541884]  fc_rport_final_delete+0xf3/0x1d0 [scsi_transport_fc]
    [  584.573823]  process_one_work+0x1e3/0x3b0
    [  584.592396]  worker_thread+0x50/0x3b0
    [  584.609256]  ? rescuer_thread+0x370/0x370
    [  584.628877]  kthread+0x149/0x170
    [  584.643673]  ? set_kthread_struct+0x40/0x40
    [  584.662909]  ret_from_fork+0x22/0x30
    [  584.680002] ---[ end trace 53575ecefa942ece ]---

Signed-off-by: John Meneghini <jmeneghi@redhat.com>
Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
---
 drivers/scsi/bnx2fc/bnx2fc_fcoe.c | 20 +++++---------------
 1 file changed, 5 insertions(+), 15 deletions(-)

diff --git a/drivers/scsi/bnx2fc/bnx2fc_fcoe.c b/drivers/scsi/bnx2fc/bnx2fc_fcoe.c
index 71fa62bd3083..9be273c320e2 100644
--- a/drivers/scsi/bnx2fc/bnx2fc_fcoe.c
+++ b/drivers/scsi/bnx2fc/bnx2fc_fcoe.c
@@ -82,7 +82,7 @@ static int bnx2fc_bind_pcidev(struct bnx2fc_hba *hba);
 static void bnx2fc_unbind_pcidev(struct bnx2fc_hba *hba);
 static struct fc_lport *bnx2fc_if_create(struct bnx2fc_interface *interface,
 				  struct device *parent, int npiv);
-static void bnx2fc_destroy_work(struct work_struct *work);
+static void bnx2fc_port_destroy(struct fcoe_port *port);
 
 static struct bnx2fc_hba *bnx2fc_hba_lookup(struct net_device *phys_dev);
 static struct bnx2fc_interface *bnx2fc_interface_lookup(struct net_device
@@ -907,9 +907,6 @@ static void bnx2fc_indicate_netevent(void *context, unsigned long event,
 				__bnx2fc_destroy(interface);
 		}
 		mutex_unlock(&bnx2fc_dev_lock);
-
-		/* Ensure ALL destroy work has been completed before return */
-		flush_workqueue(bnx2fc_wq);
 		return;
 
 	default:
@@ -1215,8 +1212,8 @@ static int bnx2fc_vport_destroy(struct fc_vport *vport)
 	mutex_unlock(&n_port->lp_mutex);
 	bnx2fc_free_vport(interface->hba, port->lport);
 	bnx2fc_port_shutdown(port->lport);
+	bnx2fc_port_destroy(port);
 	bnx2fc_interface_put(interface);
-	queue_work(bnx2fc_wq, &port->destroy_work);
 	return 0;
 }
 
@@ -1525,7 +1522,6 @@ static struct fc_lport *bnx2fc_if_create(struct bnx2fc_interface *interface,
 	port->lport = lport;
 	port->priv = interface;
 	port->get_netdev = bnx2fc_netdev;
-	INIT_WORK(&port->destroy_work, bnx2fc_destroy_work);
 
 	/* Configure fcoe_port */
 	rc = bnx2fc_lport_config(lport);
@@ -1653,8 +1649,8 @@ static void __bnx2fc_destroy(struct bnx2fc_interface *interface)
 	bnx2fc_interface_cleanup(interface);
 	bnx2fc_stop(interface);
 	list_del(&interface->list);
+	bnx2fc_port_destroy(port);
 	bnx2fc_interface_put(interface);
-	queue_work(bnx2fc_wq, &port->destroy_work);
 }
 
 /**
@@ -1694,15 +1690,12 @@ static int bnx2fc_destroy(struct net_device *netdev)
 	return rc;
 }
 
-static void bnx2fc_destroy_work(struct work_struct *work)
+static void bnx2fc_port_destroy(struct fcoe_port *port)
 {
-	struct fcoe_port *port;
 	struct fc_lport *lport;
 
-	port = container_of(work, struct fcoe_port, destroy_work);
 	lport = port->lport;
-
-	BNX2FC_HBA_DBG(lport, "Entered bnx2fc_destroy_work\n");
+	BNX2FC_HBA_DBG(lport, "Entered %s, destroying lport %p\n", __func__, lport);
 
 	bnx2fc_if_destroy(lport);
 }
@@ -2556,9 +2549,6 @@ static void bnx2fc_ulp_exit(struct cnic_dev *dev)
 			__bnx2fc_destroy(interface);
 	mutex_unlock(&bnx2fc_dev_lock);
 
-	/* Ensure ALL destroy work has been completed before return */
-	flush_workqueue(bnx2fc_wq);
-
 	bnx2fc_ulp_stop(hba);
 	/* unregister cnic device */
 	if (test_and_clear_bit(BNX2FC_CNIC_REGISTERED, &hba->reg_with_cnic))
-- 
2.27.0

