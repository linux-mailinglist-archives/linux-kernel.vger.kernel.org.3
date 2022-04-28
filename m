Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E7BE512D78
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 09:55:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343596AbiD1H45 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 03:56:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241907AbiD1H4m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 03:56:42 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A45F5F245;
        Thu, 28 Apr 2022 00:53:28 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 354692186F;
        Thu, 28 Apr 2022 07:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1651132407; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=3E7uGHyVSRLlv1q/BP8AWtqLSArF2xlrVNvb53ZZO3Q=;
        b=r3XSYHwZGjPKGDDJnE8y1TzQDS660lC8ubSYtSgv3fDXdqTjp7PRW3yk4VmEGD0yYctRb6
        N2Cad7N/zT3wVToO0LIRMHi7Q5SA4KFmR6GDtMgWqzUho8hMvGo68rdSEeCKN5QsOTJ96V
        OTggVTVRIKMzc52CNcHY5fN1SxcXrG0=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E100C13AF8;
        Thu, 28 Apr 2022 07:53:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id qNCTNfZHamIoHAAAMHmgww
        (envelope-from <jgross@suse.com>); Thu, 28 Apr 2022 07:53:26 +0000
From:   Juergen Gross <jgross@suse.com>
To:     xen-devel@lists.xenproject.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH v2 0/4] xen/pv-scsi: update header and harden frontend
Date:   Thu, 28 Apr 2022 09:53:19 +0200
Message-Id: <20220428075323.12853-1-jgross@suse.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the Xen PV-scsi interface from the Xen tree and adapt the
related drivers to use the new definitions.

Harden the frontend driver to be no longer vulnerable to a malicious
backend.

Juergen Gross (4):
  xen: update vscsiif.h
  xen/scsiback: use new command result macros
  xen/scsifront: use new command result macros
  xen/scsifront: harden driver against malicious backend

 drivers/scsi/xen-scsifront.c       | 168 ++++++++++++++++++++++-------
 drivers/xen/xen-scsiback.c         |  82 +++++++++++++-
 include/xen/interface/io/vscsiif.h | 133 ++++++++++++++++++++++-
 3 files changed, 340 insertions(+), 43 deletions(-)

-- 
2.34.1

