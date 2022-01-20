Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 727CB495618
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 22:50:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377995AbiATVty (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 16:49:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:36733 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1377993AbiATVtw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 16:49:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642715392;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=2QvkNUTt/OtcptnHt8UmT0vF7UmvJyqV4LqYjKwOhy4=;
        b=Zx9sYz7EI+KJRA2GGuYmUNBeLq306qbCwg68zP305WKVzQiwRN3PueMPCrI6bxef6SL4w1
        yjrmsHreZsQTqme91/vsfvEezTO8LYbWWwOY/dm2/a/vZpq/IuLiKLGnP/CasZGmRoU0sl
        UWfs1QqSenIw7P9sk8fxl9/Cuq2Ifc4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-168-TxVH5WulO12Aj3iLaW6pXg-1; Thu, 20 Jan 2022 16:49:50 -0500
X-MC-Unique: TxVH5WulO12Aj3iLaW6pXg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C002F1006AA3;
        Thu, 20 Jan 2022 21:49:49 +0000 (UTC)
Received: from aion.usersys.redhat.com (unknown [10.22.8.154])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A22BA56F8B;
        Thu, 20 Jan 2022 21:49:49 +0000 (UTC)
Received: by aion.usersys.redhat.com (Postfix, from userid 1000)
        id D9EF61A001F; Thu, 20 Jan 2022 16:49:48 -0500 (EST)
From:   Scott Mayhew <smayhew@redhat.com>
To:     selinux@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH RFC v2 0/2] selinux: parse sids earlier to avoid doing memory allocations under spinlock
Date:   Thu, 20 Jan 2022 16:49:46 -0500
Message-Id: <20220120214948.3637895-1-smayhew@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

selinux_sb_mnt_opts_compat() is called under the sb_lock spinlock and
shouldn't be performing any memory allocations. 

The first patch fixes this by parsing the sids at the same time the
context mount options are being parsed from the mount options string
and storing the parsed sids in the selinux_mnt_opts struct. 

The second patch adds logic to selinux_set_mnt_opts() and
selinux_sb_remount() that checks to see if a sid has already been
parsed before calling parse_sid(), and adds the parsed sids to the
data being copied in selinux_fs_context_dup().

Scott Mayhew (2):
  selinux: Fix selinux_sb_mnt_opts_compat()
  selinux: try to use preparsed sid before calling parse_sid()

 security/selinux/hooks.c | 181 ++++++++++++++++++++++++++++-----------
 1 file changed, 129 insertions(+), 52 deletions(-)

-- 
2.31.1

