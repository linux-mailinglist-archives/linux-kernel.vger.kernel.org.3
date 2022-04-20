Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 811CF5084E4
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 11:25:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377209AbiDTJ2D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 05:28:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234247AbiDTJ1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 05:27:53 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51516262F;
        Wed, 20 Apr 2022 02:25:07 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 0849C1F380;
        Wed, 20 Apr 2022 09:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1650446706; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=3E7uGHyVSRLlv1q/BP8AWtqLSArF2xlrVNvb53ZZO3Q=;
        b=NMLVxS0XMRvWXReWNfowiUHySlIATTs0qYOx3BLmMovlp82yKFTiB3IwQ4F/agcqzd0JHr
        VFlhKH2x+iPFwtXn4eQ7JsfcC3e4ClBot4vi8F3e+C75NLAw9vAQuyx0PZQpDvYC1ln1AS
        4YxztFMutLngFG/7ISGEdFELcUZmNEc=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B698C13A30;
        Wed, 20 Apr 2022 09:25:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id FzNFK3HRX2J1EAAAMHmgww
        (envelope-from <jgross@suse.com>); Wed, 20 Apr 2022 09:25:05 +0000
From:   Juergen Gross <jgross@suse.com>
To:     xen-devel@lists.xenproject.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 0/4] xen/pv-scsi: update header and harden frontend
Date:   Wed, 20 Apr 2022 11:24:59 +0200
Message-Id: <20220420092503.11123-1-jgross@suse.com>
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

