Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A37864A492F
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 15:17:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233827AbiAaOR5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 09:17:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231189AbiAaORz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 09:17:55 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0441CC061714
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 06:17:55 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id j2so43087629ejk.6
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 06:17:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mTDCObLZiJqqNd5/Xm8EoHS2mhf1Esr2zwHrRGTOotI=;
        b=FUO7bI+8scBoLuzJF/TM2nrriJrbEWBGI3MVuxlUvAqI8PriJEy1CM4R8tWo8GLKm1
         GIjEiXf1y5BpiuVcuxYRc/v9knhNBrzTGFKkRQoFJYwiXab3gAMljwFz9BGgyYMwRPor
         phs9En1NnHLTVnHwqtNK/Ri031g/JPVWLYx5n4u3qaPYRPRoISIuMILWVveUqPaDph8m
         SYnJj+RT18qN9WzBgJCs2lopZZoEWqY/refZXyEDqvf4THZAg4YSBumkrMmTcn8UEWbv
         ZKfFWF/sDG/rsfH2ptS1K4jeNeQIMMoMm36GNTsjs1YRf0jKkl6pUI99hn+wpJAFtPAU
         +qQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mTDCObLZiJqqNd5/Xm8EoHS2mhf1Esr2zwHrRGTOotI=;
        b=KrF5NbadyZa9by0o2JNvjNIlNia6SCuTayJNTFN0RGvIQYhmMupekOfVSyMFAlCDLs
         hOoSqRvuV6MZEsRQKTv3qqHsxe9YW6JbTLJmEGeE5EaMy0ccaUGQyrsdL7AmuwtQ93tj
         u3I6KiZKwoCZpih02skDnk1Nnv+rdKbeOb5coJkkd1HcaO7L7prziFjOG6izNu2Oih+I
         JLXVY3ZF0icyxrrihLdl6KlCa5ggADWWVLPSQ4t7ugbxqKsK5Psc3G3EnzpgfGpmuRVJ
         Aw9kf0baNVmVouYn5klJ3zSobvKC+9dAdiHowLRAOf5Y+puRP2LThtKovpq9mIDnNPxV
         qy2w==
X-Gm-Message-State: AOAM532EmhVy2SadQHLQD9aheb5G6FyuZDj2R2wUS9JrOxDx2gEwPA+v
        glSnbVFs9eRTDlHVO2ibarLE9oKjCxeFRcd7RMe6XA==
X-Google-Smtp-Source: ABdhPJw57VoVmQlHI/WE2YiNtWnr1tGBJpC/hgZFws6gJW13Zq0wtbMT38h9enYhWHQOyGdP/AJ+5oyy/RN/YJ63pmo=
X-Received: by 2002:a17:907:1a42:: with SMTP id mf2mr17060738ejc.103.1643638673024;
 Mon, 31 Jan 2022 06:17:53 -0800 (PST)
MIME-Version: 1.0
References: <20220125002025.GA21887@agk-cloud1.hosts.prod.upshift.rdu2.redhat.com>
 <20220126192234.572058-1-bgeffon@google.com>
In-Reply-To: <20220126192234.572058-1-bgeffon@google.com>
From:   Brian Geffon <bgeffon@google.com>
Date:   Mon, 31 Jan 2022 09:17:17 -0500
Message-ID: <CADyq12yugY0g2EMYvyrPVn98x3Tp4PR+eVddmmjZpKSYyrrzag@mail.gmail.com>
Subject: Re: [PATCH] dm: introduce a DM_ENFORCE_OPEN_COUNT flag.
To:     Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@redhat.com>
Cc:     dm-devel@redhat.com, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 26, 2022 at 2:22 PM Brian Geffon <bgeffon@google.com> wrote:
>
> This change introduces a new flag which can be used with
> DM_DEV_CREATE to establish the maximum open count allowed
> for a device. When this flag is set on DM_DEV_CREATE the
> open_count on dm_ioctl will be intrpreted as an input
> parameter. This value must be >= 1 or DM_DEV_CREATE will
> return -ERANGE.
>
> When this flag is set when the open count is equal to
> the max open count any future opens will result in an
> -EBUSY.
>

Hi Alasdair,
I was curious if you had any thoughts on this particular alternative
approach to this problem, I'm open to any suggestions of alternative
implementations.

Thank you in advance,
Brian


>
> Signed-off-by: Brian Geffon <bgeffon@google.com>
> ---
>  drivers/md/dm-core.h          |  2 ++
>  drivers/md/dm-ioctl.c         | 13 ++++++++++++
>  drivers/md/dm.c               | 39 ++++++++++++++++++++++++++++++++---
>  drivers/md/dm.h               |  7 +++++++
>  include/uapi/linux/dm-ioctl.h |  9 +++++++-
>  5 files changed, 66 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/md/dm-core.h b/drivers/md/dm-core.h
> index 55dccdfbcb22..57922a80026e 100644
> --- a/drivers/md/dm-core.h
> +++ b/drivers/md/dm-core.h
> @@ -57,6 +57,7 @@ struct mapped_device {
>
>         atomic_t holders;
>         atomic_t open_count;
> +       int max_open_count;
>
>         struct dm_target *immutable_target;
>         struct target_type *immutable_target_type;
> @@ -139,6 +140,7 @@ struct mapped_device {
>  #define DMF_SUSPENDED_INTERNALLY 7
>  #define DMF_POST_SUSPENDING 8
>  #define DMF_EMULATE_ZONE_APPEND 9
> +#define DMF_ENFORCE_OPEN_COUNT 10
>
>  void disable_discard(struct mapped_device *md);
>  void disable_write_same(struct mapped_device *md);
> diff --git a/drivers/md/dm-ioctl.c b/drivers/md/dm-ioctl.c
> index 21fe8652b095..8ddf3ab99ef6 100644
> --- a/drivers/md/dm-ioctl.c
> +++ b/drivers/md/dm-ioctl.c
> @@ -814,6 +814,9 @@ static void __dev_status(struct mapped_device *md, struct dm_ioctl *param)
>         if (dm_test_deferred_remove_flag(md))
>                 param->flags |= DM_DEFERRED_REMOVE;
>
> +       if (dm_test_enforce_open_count_flag(md))
> +               param->flags |= DM_ENFORCE_OPEN_COUNT_FLAG;
> +
>         param->dev = huge_encode_dev(disk_devt(disk));
>
>         /*
> @@ -866,6 +869,16 @@ static int dev_create(struct file *filp, struct dm_ioctl *param, size_t param_si
>         if (r)
>                 return r;
>
> +       if (param->flags & DM_ENFORCE_OPEN_COUNT_FLAG) {
> +               if (param->open_count < 1) {
> +                       dm_put(md);
> +                       dm_destroy(md);
> +                       return -ERANGE;
> +               }
> +
> +               dm_set_max_open_count(md, param->open_count);
> +       }
> +
>         r = dm_hash_insert(param->name, *param->uuid ? param->uuid : NULL, md);
>         if (r) {
>                 dm_put(md);
> diff --git a/drivers/md/dm.c b/drivers/md/dm.c
> index 76d9da49fda7..718bc9fce7c1 100644
> --- a/drivers/md/dm.c
> +++ b/drivers/md/dm.c
> @@ -307,6 +307,7 @@ int dm_deleting_md(struct mapped_device *md)
>  static int dm_blk_open(struct block_device *bdev, fmode_t mode)
>  {
>         struct mapped_device *md;
> +       int ret = -ENXIO;
>
>         spin_lock(&_minor_lock);
>
> @@ -316,16 +317,28 @@ static int dm_blk_open(struct block_device *bdev, fmode_t mode)
>
>         if (test_bit(DMF_FREEING, &md->flags) ||
>             dm_deleting_md(md)) {
> -               md = NULL;
>                 goto out;
>         }
>
>         dm_get(md);
> +
> +       if (test_bit(DMF_ENFORCE_OPEN_COUNT, &md->flags)) {
> +               /*
> +                * No opens or closes can happen in parallel as both
> +                * paths hold the _minor_lock.
> +                */
> +               if (atomic_read(&md->open_count) + 1 > md->max_open_count) {
> +                       dm_put(md);
> +                       ret = -EBUSY;
> +                       goto out;
> +               }
> +       }
> +
>         atomic_inc(&md->open_count);
> +       ret = 0;
>  out:
>         spin_unlock(&_minor_lock);
> -
> -       return md ? 0 : -ENXIO;
> +       return ret;
>  }
>
>  static void dm_blk_close(struct gendisk *disk, fmode_t mode)
> @@ -2219,6 +2232,21 @@ void dm_put(struct mapped_device *md)
>  }
>  EXPORT_SYMBOL_GPL(dm_put);
>
> +/*
> + * dm_set_max_open count can only be called when the device is created,
> + * it cannot be changed once set.
> + */
> +void dm_set_max_open_count(struct mapped_device *md, int count)
> +{
> +       /*
> +        * The max open count cannot be changed
> +        */
> +       BUG_ON(test_bit(DMF_ENFORCE_OPEN_COUNT, &md->flags));
> +
> +       set_bit(DMF_ENFORCE_OPEN_COUNT, &md->flags);
> +       md->max_open_count = count;
> +}
> +
>  static bool md_in_flight_bios(struct mapped_device *md)
>  {
>         int cpu;
> @@ -2795,6 +2823,11 @@ int dm_test_deferred_remove_flag(struct mapped_device *md)
>         return test_bit(DMF_DEFERRED_REMOVE, &md->flags);
>  }
>
> +int dm_test_enforce_open_count_flag(struct mapped_device *md)
> +{
> +       return test_bit(DMF_ENFORCE_OPEN_COUNT, &md->flags);
> +}
> +
>  int dm_suspended(struct dm_target *ti)
>  {
>         return dm_suspended_md(ti->table->md);
> diff --git a/drivers/md/dm.h b/drivers/md/dm.h
> index 742d9c80efe1..82f56a066b83 100644
> --- a/drivers/md/dm.h
> +++ b/drivers/md/dm.h
> @@ -84,6 +84,8 @@ void dm_set_md_type(struct mapped_device *md, enum dm_queue_mode type);
>  enum dm_queue_mode dm_get_md_type(struct mapped_device *md);
>  struct target_type *dm_get_immutable_target_type(struct mapped_device *md);
>
> +void dm_set_max_open_count(struct mapped_device *md, int count);
> +
>  int dm_setup_md_queue(struct mapped_device *md, struct dm_table *t);
>
>  /*
> @@ -162,6 +164,11 @@ void dm_internal_resume(struct mapped_device *md);
>   */
>  int dm_test_deferred_remove_flag(struct mapped_device *md);
>
> +/*
> + * Test if the device is enforcing an open count.
> + */
> +int dm_test_enforce_open_count_flag(struct mapped_device *md);
> +
>  /*
>   * Try to remove devices marked for deferred removal.
>   */
> diff --git a/include/uapi/linux/dm-ioctl.h b/include/uapi/linux/dm-ioctl.h
> index c12ce30b52df..9da3700c0442 100644
> --- a/include/uapi/linux/dm-ioctl.h
> +++ b/include/uapi/linux/dm-ioctl.h
> @@ -123,7 +123,7 @@ struct dm_ioctl {
>                                  * relative to start of this struct */
>
>         __u32 target_count;     /* in/out */
> -       __s32 open_count;       /* out */
> +       __s32 open_count;       /* in/out, in on DM_DEV_CREATE only */
>         __u32 flags;            /* in/out */
>
>         /*
> @@ -382,4 +382,11 @@ enum {
>   */
>  #define DM_IMA_MEASUREMENT_FLAG        (1 << 19) /* In */
>
> +/*
> + * If set with DM_DEV_CREATE then the open_count on device creation
> + * will be set as the maximum concurrent opens allowed on the device.
> + * Once the open_count has been hit any new opens will result in
> + * -EBUSY until other users close the device.
> + */
> +#define DM_ENFORCE_OPEN_COUNT_FLAG      (1 << 20) /* In/Out */
>  #endif                         /* _LINUX_DM_IOCTL_H */
> --
> 2.35.0.rc0.227.g00780c9af4-goog
>
