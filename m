Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC5885676F5
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 20:56:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232917AbiGES4N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 14:56:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230185AbiGES4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 14:56:10 -0400
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E028E1B7AE;
        Tue,  5 Jul 2022 11:56:08 -0700 (PDT)
Received: by mail-yb1-f175.google.com with SMTP id e69so16893891ybh.2;
        Tue, 05 Jul 2022 11:56:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6lb/COsTw/Yi6jNORtkg8dNZ2wmUs9sMaIBSDV796s4=;
        b=DsXazNkDOkkB5tF6zcG5/XNnSwyFKu10KNHLbiIArht0q63k62quk/iPpkA3oOEjTI
         cdbVqUPdL0Fn4ZGGYOzrmqkIN99okofEE5fvjSW5AwOMaMtscnqTlJzKZU+fAcYbsjtr
         JNmJskKsPtRhFsWmXGgJhi1EJ+xgdGT9G+71+MYuEUvZcz+AAJWuoRjEdsSAqZHZCbDR
         2StvSRgeq/BH2uVyXi0jJTaLHddT5DxxBr4GFiO1TMn3zqrqJZCNLzmGwR35P7ias5Ze
         wQNt6YpCo+SoubgJzmJkJrYxy8D2kA5BU5NhuMGP/uTLmzPpqnI5kWV6Y8Bb7XVl99z4
         ZyIw==
X-Gm-Message-State: AJIora//Nw/9crvy81tC4GTh0j/GgPuIxEKOUI1F5VwCzqt8vL1x+jQi
        N5xrg1lvjAknkJygzUEHY/mzl41KjKxCRLKFXH8=
X-Google-Smtp-Source: AGRyM1vwcWagIDDdHSsIYmWswFFY6iJARfo9P5PiM2Zq9xwKbEr54ojks5kFS3t2x4uoJIsEjsXd+MxMsla6oYMh/VQ=
X-Received: by 2002:a25:9847:0:b0:669:b4c6:d081 with SMTP id
 k7-20020a259847000000b00669b4c6d081mr37902769ybo.633.1657047368140; Tue, 05
 Jul 2022 11:56:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220514141932.53938-1-wudaemon@163.com>
In-Reply-To: <20220514141932.53938-1-wudaemon@163.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 5 Jul 2022 20:55:57 +0200
Message-ID: <CAJZ5v0jOpJhdLEdOr5EY5v_e2AXcn_1pt71F3t_KqCZe=ntd=Q@mail.gmail.com>
Subject: Re: [PATCH v2] thermal/core: Make trans_table tunnable to avoid some
 needless zero output
To:     Junwen Wu <wudaemon@163.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        "Zhang, Rui" <rui.zhang@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for the delay.

On Sat, May 14, 2022 at 4:20 PM Junwen Wu <wudaemon@163.com> wrote:
>
> Very high cooling device max state value make trans_table node
> prompt File too large. We introduce show_state node, tunnable
> by user,thus trans_table only show show_state'th trans count to
> the max trans count, in this way trans_table_show's buffer is
> always less than PAGE_SIZE and shows the important changes.

This changelog is rather hard to understand.

As far as the code changes go, you cannot add new sysfs attributes
arbitrarily without documenting them.

Also, is the proposed change compatible with all existing user space
that may be using the sysfs modified by this change?

> Signed-off-by: Junwen Wu <wudaemon@163.com>
> ---
>  drivers/thermal/thermal_sysfs.c | 111 +++++++++++++++++++++++++-------
>  1 file changed, 86 insertions(+), 25 deletions(-)
>
> diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
> index f154bada2906..bb8627aa49b7 100644
> --- a/drivers/thermal/thermal_sysfs.c
> +++ b/drivers/thermal/thermal_sysfs.c
> @@ -656,6 +656,7 @@ struct cooling_dev_stats {
>         spinlock_t lock;
>         unsigned int total_trans;
>         unsigned long state;
> +       unsigned long show_state;
>         unsigned long max_states;
>         ktime_t last_time;
>         ktime_t *time_in_state;
> @@ -752,38 +753,93 @@ reset_store(struct device *dev, struct device_attribute *attr, const char *buf,
>         return count;
>  }
>
> -static ssize_t trans_table_show(struct device *dev,
> -                               struct device_attribute *attr, char *buf)
> +static ssize_t
> +show_state_store(struct device *dev, struct device_attribute *attr, const char *buf,
> +               size_t count)
>  {
>         struct thermal_cooling_device *cdev = to_cooling_device(dev);
>         struct cooling_dev_stats *stats = cdev->stats;
> -       ssize_t len = 0;
> -       int i, j;
> +       unsigned long state;
> +       ssize_t ret;
>
> -       len += snprintf(buf + len, PAGE_SIZE - len, " From  :    To\n");
> -       len += snprintf(buf + len, PAGE_SIZE - len, "       : ");
> -       for (i = 0; i < stats->max_states; i++) {
> -               if (len >= PAGE_SIZE)
> -                       break;
> -               len += snprintf(buf + len, PAGE_SIZE - len, "state%2u  ", i);
> -       }
> -       if (len >= PAGE_SIZE)
> -               return PAGE_SIZE;
> +       spin_lock(&stats->lock);
> +
> +       ret = kstrtoul(buf, 10, &state);
> +       if (ret || (state > stats->max_states))
> +               goto unlock;
>
> -       len += snprintf(buf + len, PAGE_SIZE - len, "\n");
> +       stats->show_state = state;
> +unlock:
> +       spin_unlock(&stats->lock);
>
> -       for (i = 0; i < stats->max_states; i++) {
> -               if (len >= PAGE_SIZE)
> -                       break;
> +       return count;
> +}
> +
> +static ssize_t
> +show_state_show(struct device *dev, struct device_attribute *attr, char *buf)
> +{
> +       struct thermal_cooling_device *cdev = to_cooling_device(dev);
> +       struct cooling_dev_stats *stats = cdev->stats;
> +
> +       return sprintf(buf, "%lu\n", stats->show_state);
> +}
>
> -               len += snprintf(buf + len, PAGE_SIZE - len, "state%2u:", i);
> +/* find the kth largest in nums array*/
> +static int find_show_state(int *nums, int numsSize, int k, unsigned int *max_value)
> +{
> +       int i, l, r, mid, cnt = 0, min = INT_MAX, max = 0;
>
> -               for (j = 0; j < stats->max_states; j++) {
> -                       if (len >= PAGE_SIZE)
> -                               break;
> -                       len += snprintf(buf + len, PAGE_SIZE - len, "%8u ",
> -                               stats->trans_table[i * stats->max_states + j]);
> +       for (i = 0; i < numsSize; i++) {
> +               min = nums[i] < min ? nums[i] : min;
> +               max = nums[i] > max ? nums[i] : max;
> +       }
> +       l = min;
> +       r = max;
> +       while (l < r) {
> +               mid = r - (r - l) / 2;
> +               for (i = 0; i < numsSize; i++) {
> +                       if (nums[i] >= mid)
> +                               cnt++;
> +               }
> +               if (cnt < k) {
> +                       r = mid - 1;
> +                       cnt = 0;
> +               } else {
> +                       l = mid;
> +                       cnt = 0;
>                 }
> +       }
> +
> +       *max_value = max;
> +
> +       return l;
> +}
> +
> +
> +
> +static ssize_t trans_table_show(struct device *dev,
> +                               struct device_attribute *attr, char *buf)
> +{
> +       struct thermal_cooling_device *cdev = to_cooling_device(dev);
> +       struct cooling_dev_stats *stats = cdev->stats;
> +       unsigned int show_state_value = 0;
> +       unsigned int max_state_value = 0;
> +       ssize_t len = 0;
> +       int i, j;
> +
> +       len += snprintf(buf + len, PAGE_SIZE - len, " From  :    Index_change\n");
> +       for (i = 0; i < stats->max_states; i++) {
> +               show_state_value = find_show_state(&stats->trans_table[i * stats->max_states],
> +                               stats->max_states, stats->show_state, &max_state_value);
> +               if (max_state_value)
> +                       len += snprintf(buf + len, PAGE_SIZE - len, "state%2u:", i);
> +               else
> +                       continue;
> +               for (j = 0; j < stats->max_states; j++)
> +                       if (stats->trans_table[i * stats->max_states + j] && (show_state_value <=
> +                                               stats->trans_table[i * stats->max_states + j]))
> +                               len += snprintf(buf + len, PAGE_SIZE - len, "     ->%u(%u)", j,
> +                                               stats->trans_table[i * stats->max_states + j]);
>                 if (len >= PAGE_SIZE)
>                         break;
>                 len += snprintf(buf + len, PAGE_SIZE - len, "\n");
> @@ -793,6 +849,7 @@ static ssize_t trans_table_show(struct device *dev,
>                 pr_warn_once("Thermal transition table exceeds PAGE_SIZE. Disabling\n");
>                 return -EFBIG;
>         }
> +
>         return len;
>  }
>
> @@ -800,12 +857,14 @@ static DEVICE_ATTR_RO(total_trans);
>  static DEVICE_ATTR_RO(time_in_state_ms);
>  static DEVICE_ATTR_WO(reset);
>  static DEVICE_ATTR_RO(trans_table);
> +static DEVICE_ATTR_RW(show_state);
>
>  static struct attribute *cooling_device_stats_attrs[] = {
>         &dev_attr_total_trans.attr,
>         &dev_attr_time_in_state_ms.attr,
>         &dev_attr_reset.attr,
>         &dev_attr_trans_table.attr,
> +       &dev_attr_show_state.attr,
>         NULL
>  };
>
> @@ -829,7 +888,7 @@ static void cooling_device_stats_setup(struct thermal_cooling_device *cdev)
>         var += sizeof(*stats->time_in_state) * states;
>         var += sizeof(*stats->trans_table) * states * states;
>
> -       stats = kzalloc(var, GFP_KERNEL);
> +       stats = kvzalloc(var, GFP_KERNEL);
>         if (!stats)
>                 return;
>
> @@ -838,6 +897,8 @@ static void cooling_device_stats_setup(struct thermal_cooling_device *cdev)
>         cdev->stats = stats;
>         stats->last_time = ktime_get();
>         stats->max_states = states;
> +       /* default set show_state = max_states/2 */
> +       stats->show_state = states / 2;
>
>         spin_lock_init(&stats->lock);
>
> @@ -848,7 +909,7 @@ static void cooling_device_stats_setup(struct thermal_cooling_device *cdev)
>
>  static void cooling_device_stats_destroy(struct thermal_cooling_device *cdev)
>  {
> -       kfree(cdev->stats);
> +       kvfree(cdev->stats);
>         cdev->stats = NULL;
>  }
>
> --
> 2.25.1
>
