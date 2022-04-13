Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E56A14FFDE0
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 20:32:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237738AbiDMSec (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 14:34:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230122AbiDMSea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 14:34:30 -0400
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2921E5A17C;
        Wed, 13 Apr 2022 11:32:08 -0700 (PDT)
Received: by mail-yb1-f176.google.com with SMTP id i20so5306487ybj.7;
        Wed, 13 Apr 2022 11:32:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FnV+MQwchXhr3MKmgvUaNja+2ao2/UWo8YjHem4hplQ=;
        b=RsNV9vF/DLRjonJfuzQMBIvOF49xLVe2ZZIqHKTcMbpSY3L5vmAE1KZmKYG4uz62g9
         3x+ccDgERqcWLkHduL8gqVTIi3/R2TzkREsDRKuHjyiOQtUkEnJXFJhRPmoIiZnC7loY
         xGFqp049y58fNsdxu8fgen67/cmVwVGUWm79UfdqGyHn+9rbMEnAewpVVlcYGStAVuxO
         0L0LHgrxCIMASe+ZLcOEsqtPgTDP66d0118e+T6RBF4lhlvOCQW1XzMZ3C017OsYOzzj
         ztvdkGJWAiKxoEUi5WIgPdhOYjbm11fV8YPlelaUFQXpq3H+C97zs0bVR7jB/7tpI0Km
         07LQ==
X-Gm-Message-State: AOAM530UhHllqdiGvxw8gmixo8HlW63GQQG8UfLj6gYbV9T1JTg4iMaa
        IEwvhU0MF2hSy5W0CpIJFKUJHOCqiQh4peg3Ng8=
X-Google-Smtp-Source: ABdhPJywS+ympGney5H5NvIchnG1g8tq6GWXJv6I6/63O9sX7MjWOUj7b9lxZYND1sehv+8nM4FFkeuQWgG9PODSTKM=
X-Received: by 2002:a05:6902:187:b0:63d:9c95:edca with SMTP id
 t7-20020a056902018700b0063d9c95edcamr169367ybh.81.1649874727367; Wed, 13 Apr
 2022 11:32:07 -0700 (PDT)
MIME-Version: 1.0
References: <1649732719-4304-1-git-send-email-liuxp11@chinatelecom.cn>
In-Reply-To: <1649732719-4304-1-git-send-email-liuxp11@chinatelecom.cn>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 13 Apr 2022 20:31:56 +0200
Message-ID: <CAJZ5v0j2m893y1Onqq3OE12Dhrmk84zeHdEviaxK7Z2t_gMbOQ@mail.gmail.com>
Subject: Re: [PATCH v7] ACPI: APEI: fix missing erst record id
To:     Liu Xinpeng <liuxp11@chinatelecom.cn>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Robert Moore <robert.moore@intel.com>,
        Tony Luck <tony.luck@intel.com>, Len Brown <lenb@kernel.org>,
        James Morse <james.morse@arm.com>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Huang Ying <ying.huang@intel.com>, gong.chen@linux.intel.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
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

On Tue, Apr 12, 2022 at 5:05 AM Liu Xinpeng <liuxp11@chinatelecom.cn> wrote:
>
> Read a record is cleared by others, but the deleted record cache entry is
> still created by erst_get_record_id_next. When next enumerate the records,
> get the cached deleted record, then erst_read return -ENOENT and try to
> get next record, loop back to first ID will return 0 in function
> __erst_record_id_cache_add_one and then set record_id as
> APEI_ERST_INVALID_RECORD_ID, finished this time read operation.
> It will result in read the records just in the cache hereafter.
>
> This patch cleared the deleted record cache, fix the issue that
> "./erst-inject -p" shows record counts not equal to "./erst-inject -n".
>
> A reproducer of the problem(retry many times):
>
> [root@localhost erst-inject]# ./erst-inject -c 0xaaaaa00011
> [root@localhost erst-inject]# ./erst-inject -p
> rc: 273
> rcd sig: CPER
> rcd id: 0xaaaaa00012
> rc: 273
> rcd sig: CPER
> rcd id: 0xaaaaa00013
> rc: 273
> rcd sig: CPER
> rcd id: 0xaaaaa00014
> [root@localhost erst-inject]# ./erst-inject -i 0xaaaaa000006
> [root@localhost erst-inject]# ./erst-inject -i 0xaaaaa000007
> [root@localhost erst-inject]# ./erst-inject -i 0xaaaaa000008
> [root@localhost erst-inject]# ./erst-inject -p
> rc: 273
> rcd sig: CPER
> rcd id: 0xaaaaa00012
> rc: 273
> rcd sig: CPER
> rcd id: 0xaaaaa00013
> rc: 273
> rcd sig: CPER
> rcd id: 0xaaaaa00014
> [root@localhost erst-inject]# ./erst-inject -n
> total error record count: 6
>
> Changelog:
> v1->v2  Fix style problems
> v2->v3  Fix apei_read_mce called erst_get_record_id_next and modify
> the commit message.
> v3->v4  Add erst_clear_cache in another retry.
> v4->v5  Implement a new function for looking for a specific record
>  type, suggested by Tony Luck.
> v5->v6  In function erst_clear_cache, using mutex_lock insead of
> mutex_lock_interruptible ensure that the cache is cleared.
>         If erst_read return value is less than record head length,
> consider it as EIO; other error return to caller; creatorid is
> not wanted, consider it ENOENT and keep the cache for other types.
> v6->v7  Rename erst_read_record arguments "recordhead" to "recordlen".
>
> Signed-off-by: Liu Xinpeng <liuxp11@chinatelecom.cn>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> ---
>  arch/x86/kernel/cpu/mce/apei.c |  8 ++--
>  drivers/acpi/apei/erst-dbg.c   |  3 +-
>  drivers/acpi/apei/erst.c       | 77 +++++++++++++++++++++++++++++++---
>  include/acpi/apei.h            |  2 +
>  4 files changed, 78 insertions(+), 12 deletions(-)
>
> diff --git a/arch/x86/kernel/cpu/mce/apei.c b/arch/x86/kernel/cpu/mce/apei.c
> index 0e3ae64d3b76..717192915f28 100644
> --- a/arch/x86/kernel/cpu/mce/apei.c
> +++ b/arch/x86/kernel/cpu/mce/apei.c
> @@ -177,16 +177,14 @@ ssize_t apei_read_mce(struct mce *m, u64 *record_id)
>         /* no more record */
>         if (*record_id == APEI_ERST_INVALID_RECORD_ID)
>                 goto out;
> -       rc = erst_read(*record_id, &rcd.hdr, sizeof(rcd));
> +       rc = erst_read_record(*record_id, &rcd.hdr, sizeof(rcd), sizeof(rcd),
> +                       &CPER_CREATOR_MCE);
>         /* someone else has cleared the record, try next one */
>         if (rc == -ENOENT)
>                 goto retry;
>         else if (rc < 0)
>                 goto out;
> -       /* try to skip other type records in storage */
> -       else if (rc != sizeof(rcd) ||
> -                !guid_equal(&rcd.hdr.creator_id, &CPER_CREATOR_MCE))
> -               goto retry;
> +
>         memcpy(m, &rcd.mce, sizeof(*m));
>         rc = sizeof(*m);
>  out:
> diff --git a/drivers/acpi/apei/erst-dbg.c b/drivers/acpi/apei/erst-dbg.c
> index c740f0faad39..8bc71cdc2270 100644
> --- a/drivers/acpi/apei/erst-dbg.c
> +++ b/drivers/acpi/apei/erst-dbg.c
> @@ -111,7 +111,8 @@ static ssize_t erst_dbg_read(struct file *filp, char __user *ubuf,
>                 goto out;
>         }
>  retry:
> -       rc = len = erst_read(id, erst_dbg_buf, erst_dbg_buf_len);
> +       rc = len = erst_read_record(id, erst_dbg_buf, erst_dbg_buf_len,
> +                       erst_dbg_buf_len, NULL);
>         /* The record may be cleared by others, try read next record */
>         if (rc == -ENOENT)
>                 goto retry_next;
> diff --git a/drivers/acpi/apei/erst.c b/drivers/acpi/apei/erst.c
> index 698d67cee052..31b077eedb58 100644
> --- a/drivers/acpi/apei/erst.c
> +++ b/drivers/acpi/apei/erst.c
> @@ -856,6 +856,74 @@ ssize_t erst_read(u64 record_id, struct cper_record_header *record,
>  }
>  EXPORT_SYMBOL_GPL(erst_read);
>
> +static void erst_clear_cache(u64 record_id)
> +{
> +       int i;
> +       u64 *entries;
> +
> +       mutex_lock(&erst_record_id_cache.lock);
> +
> +       entries = erst_record_id_cache.entries;
> +       for (i = 0; i < erst_record_id_cache.len; i++) {
> +               if (entries[i] == record_id)
> +                       entries[i] = APEI_ERST_INVALID_RECORD_ID;
> +       }
> +       __erst_record_id_cache_compact();
> +
> +       mutex_unlock(&erst_record_id_cache.lock);
> +}
> +
> +ssize_t erst_read_record(u64 record_id, struct cper_record_header *record,
> +               size_t buflen, size_t recordlen, const guid_t *creatorid)
> +{
> +       ssize_t len;
> +
> +       /*
> +        * if creatorid is NULL, read any record for erst-dbg module
> +        */
> +       if (creatorid == NULL) {
> +               len = erst_read(record_id, record, buflen);
> +               if (len == -ENOENT)
> +                       erst_clear_cache(record_id);
> +
> +               return len;
> +       }
> +
> +       len = erst_read(record_id, record, buflen);
> +       /*
> +        * if erst_read return value is -ENOENT skip to next record_id,
> +        * and clear the record_id cache.
> +        */
> +       if (len == -ENOENT) {
> +               erst_clear_cache(record_id);
> +               goto out;
> +       }
> +
> +       if (len < 0)
> +               goto out;
> +
> +       /*
> +        * if erst_read return value is less than record head length,
> +        * consider it as -EIO, and clear the record_id cache.
> +        */
> +       if (len < recordlen) {
> +               len = -EIO;
> +               erst_clear_cache(record_id);
> +               goto out;
> +       }
> +
> +       /*
> +        * if creatorid is not wanted, consider it as not found,
> +        * for skipping to next record_id.
> +        */
> +       if (!guid_equal(&record->creator_id, creatorid))
> +               len = -ENOENT;
> +
> +out:
> +       return len;
> +}
> +EXPORT_SYMBOL_GPL(erst_read_record);
> +
>  int erst_clear(u64 record_id)
>  {
>         int rc, i;
> @@ -996,16 +1064,13 @@ static ssize_t erst_reader(struct pstore_record *record)
>                 goto out;
>         }
>
> -       len = erst_read(record_id, &rcd->hdr, rcd_len);
> +       len = erst_read_record(record_id, &rcd->hdr, rcd_len, sizeof(*rcd),
> +                       &CPER_CREATOR_PSTORE);
>         /* The record may be cleared by others, try read next record */
>         if (len == -ENOENT)
>                 goto skip;
> -       else if (len < 0 || len < sizeof(*rcd)) {
> -               rc = -EIO;
> +       else if (len < 0)
>                 goto out;
> -       }
> -       if (!guid_equal(&rcd->hdr.creator_id, &CPER_CREATOR_PSTORE))
> -               goto skip;
>
>         record->buf = kmalloc(len, GFP_KERNEL);
>         if (record->buf == NULL) {
> diff --git a/include/acpi/apei.h b/include/acpi/apei.h
> index afaca3a075e8..dc60f7db5524 100644
> --- a/include/acpi/apei.h
> +++ b/include/acpi/apei.h
> @@ -46,6 +46,8 @@ int erst_get_record_id_next(int *pos, u64 *record_id);
>  void erst_get_record_id_end(void);
>  ssize_t erst_read(u64 record_id, struct cper_record_header *record,
>                   size_t buflen);
> +ssize_t erst_read_record(u64 record_id, struct cper_record_header *record,
> +               size_t buflen, size_t recordlen, const guid_t *creatorid);
>  int erst_clear(u64 record_id);
>
>  int arch_apei_enable_cmcff(struct acpi_hest_header *hest_hdr, void *data);
> --

Applied as 5.19 material, thanks!
