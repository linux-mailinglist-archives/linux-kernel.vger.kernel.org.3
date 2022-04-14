Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84ED35005C2
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 08:06:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239940AbiDNGIk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 02:08:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232683AbiDNGIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 02:08:36 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05B002459C;
        Wed, 13 Apr 2022 23:06:11 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 76F5C1F746;
        Thu, 14 Apr 2022 06:06:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1649916370; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=DjmY0y6rq2oBQX2JY+pUjqaJmts34FI97HkQ1OMEb2U=;
        b=f7ZwMUOW2flBbSrYLtMaPXKjH0GzUtYa9fIWXT5AgFPsOO83JH8U1RkR+YI5L4htgnavGY
        ILwnmuN31xaEL0OWTcw68gjXSppbyXfgmm90eI00fKXAkIDt1xJjjyH/ysu+ZDU96TCrcY
        TFL7vMHBiMWRbI4Iw7Iv1nrIsnaiXzA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1649916370;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=DjmY0y6rq2oBQX2JY+pUjqaJmts34FI97HkQ1OMEb2U=;
        b=0+T/BifuWWXRouxbH3zANxjCN1mELPBNQ9pXuemrV8kt9TU4UH3OEXm8X4SkkHVtOrmh33
        j5lSw62kgjg4qFBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D2D8013A86;
        Thu, 14 Apr 2022 06:06:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id WdudI9C5V2LMGAAAMHmgww
        (envelope-from <neilb@suse.de>); Thu, 14 Apr 2022 06:06:08 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     Song Liu <song@kernel.org>, linux-raid@vger.kernel.org,
        linux-block@vger.kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Lennart Poettering <lennart@poettering.net>
Subject: [PATCH/RFC] md: remove media-change code
Date:   Thu, 14 Apr 2022 16:06:05 +1000
Message-id: <164991636542.11576.2282590308338864748@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


md only ever used the media-change interfaces to trigger a partition
rescan once the array became active.  Normally partition scan only
happens when the disk is first added, and with md the disk is typically
inactive when first added.

This rescan can now be achieved by simply setting GD_NEED_PART_SCAN.
So do that, and remove all the rescan.

This has the side effect of causing 'diskseq' to be stable for md devices.
Preciously diskseq would be incremented once the device became active
but no uevent would be generated to report this increment.  This was
confusing to systemd.

  https://github.com/systemd/systemd/pull/23011

Signed-off-by: NeilBrown <neilb@suse.de>
---
 drivers/md/md.c | 19 ++-----------------
 drivers/md/md.h |  2 --
 2 files changed, 2 insertions(+), 19 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 309b3af906ad..0ea4d34ec682 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -5713,7 +5713,6 @@ static int md_alloc(dev_t dev, char *name)
 	mddev->queue =3D disk->queue;
 	blk_set_stacking_limits(&mddev->queue->limits);
 	blk_queue_write_cache(mddev->queue, true, true);
-	disk->events |=3D DISK_EVENT_MEDIA_CHANGE;
 	mddev->gendisk =3D disk;
 	error =3D add_disk(disk);
 	if (error)
@@ -6089,7 +6088,7 @@ int do_md_run(struct mddev *mddev)
=20
 	set_capacity_and_notify(mddev->gendisk, mddev->array_sectors);
 	clear_bit(MD_NOT_READY, &mddev->flags);
-	mddev->changed =3D 1;
+	set_bit(GD_NEED_PART_SCAN, &mddev->gendisk->state);
 	kobject_uevent(&disk_to_dev(mddev->gendisk)->kobj, KOBJ_CHANGE);
 	sysfs_notify_dirent_safe(mddev->sysfs_state);
 	sysfs_notify_dirent_safe(mddev->sysfs_action);
@@ -6191,7 +6190,6 @@ static void md_clean(struct mddev *mddev)
 	mddev->sync_speed_min =3D mddev->sync_speed_max =3D 0;
 	mddev->recovery =3D 0;
 	mddev->in_sync =3D 0;
-	mddev->changed =3D 0;
 	mddev->degraded =3D 0;
 	mddev->safemode =3D 0;
 	mddev->private =3D NULL;
@@ -6407,7 +6405,7 @@ static int do_md_stop(struct mddev *mddev, int mode,
=20
 		set_capacity_and_notify(disk, 0);
 		mutex_unlock(&mddev->open_mutex);
-		mddev->changed =3D 1;
+		set_bit(GD_NEED_PART_SCAN, &mddev->gendisk->state);
=20
 		if (mddev->ro)
 			mddev->ro =3D 0;
@@ -7839,7 +7837,6 @@ static int md_open(struct block_device *bdev, fmode_t m=
ode)
 	atomic_inc(&mddev->openers);
 	mutex_unlock(&mddev->open_mutex);
=20
-	bdev_check_media_change(bdev);
  out:
 	if (err)
 		mddev_put(mddev);
@@ -7855,17 +7852,6 @@ static void md_release(struct gendisk *disk, fmode_t m=
ode)
 	mddev_put(mddev);
 }
=20
-static unsigned int md_check_events(struct gendisk *disk, unsigned int clear=
ing)
-{
-	struct mddev *mddev =3D disk->private_data;
-	unsigned int ret =3D 0;
-
-	if (mddev->changed)
-		ret =3D DISK_EVENT_MEDIA_CHANGE;
-	mddev->changed =3D 0;
-	return ret;
-}
-
 const struct block_device_operations md_fops =3D
 {
 	.owner		=3D THIS_MODULE,
@@ -7877,7 +7863,6 @@ const struct block_device_operations md_fops =3D
 	.compat_ioctl	=3D md_compat_ioctl,
 #endif
 	.getgeo		=3D md_getgeo,
-	.check_events	=3D md_check_events,
 	.set_read_only	=3D md_set_read_only,
 };
=20
diff --git a/drivers/md/md.h b/drivers/md/md.h
index 6ac283864533..aec433ae5947 100644
--- a/drivers/md/md.h
+++ b/drivers/md/md.h
@@ -405,8 +405,6 @@ struct mddev {
 	atomic_t			active;		/* general refcount */
 	atomic_t			openers;	/* number of active opens */
=20
-	int				changed;	/* True if we might need to
-							 * reread partition info */
 	int				degraded;	/* whether md should consider
 							 * adding a spare
 							 */
--=20
2.35.2

