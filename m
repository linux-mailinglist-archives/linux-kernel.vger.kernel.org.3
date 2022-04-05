Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 787CB4F4E98
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 03:50:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1835746AbiDFAdQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 20:33:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1446442AbiDEPoh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 11:44:37 -0400
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E95E183BB;
        Tue,  5 Apr 2022 07:16:08 -0700 (PDT)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-2eba37104a2so8618977b3.0;
        Tue, 05 Apr 2022 07:16:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fkdGzGxa3fNmTPp0+kgh9EkuzHnHkxjgFCsDVXBvjaU=;
        b=VQvCIpCRPIB98olLkOHtGVDwN3Q0xVE1o5YJSq5q57aCFyziY6pSZZGs7sanMd3ySc
         DJxOSBFn8LMQVrawvCbybhkog82JodY2uM65c3vAVCXrZLH2rnTJ4zaDeSAfAESmQp9V
         zZ3tJmpti7ujS/VD+pwd88IpOStYDccDcj6N3387AIetDbM2aWAagYqzP2HpjjjVHk1H
         Nl6vdQ/FdWTQeSVlumGh/IiBqP5NU7oHVp5slIce1dca7pdUYwf8VNbR/LJ7fFe++zob
         wjpUT8g04+or081xRU1kY4VJC3zYVfUbjMZsISUtw/LLM7ZxRcSqASWmyDEnzIX+ZvWk
         k3Vw==
X-Gm-Message-State: AOAM533EDtNTq2h3hnd6fj8MlvXhS2PdZGgE57DPukEuW8fq0qzm65cl
        AnIET8/Eza8l1T9n0DmNpojOUFz4JwylqWvuTPmsQVMV
X-Google-Smtp-Source: ABdhPJwYyG2qs2nkdY44U307850mhvob8xD23++y4sv/KhP60pQm3PWpGwJe2/kAl46cJzEZmP50eHk5LIecIkqNRWU=
X-Received: by 2002:a81:1b97:0:b0:2db:640f:49d8 with SMTP id
 b145-20020a811b97000000b002db640f49d8mr2768279ywb.326.1649168167397; Tue, 05
 Apr 2022 07:16:07 -0700 (PDT)
MIME-Version: 1.0
References: <1649139253-26656-1-git-send-email-liuxp11@chinatelecom.cn>
In-Reply-To: <1649139253-26656-1-git-send-email-liuxp11@chinatelecom.cn>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 5 Apr 2022 16:15:56 +0200
Message-ID: <CAJZ5v0ikprR41nugj0-ekK3F4KkYtMBYjC+-h813wq2d9puMPA@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI: APEI: fix missing erst record id
To:     Liu Xinpeng <liuxp11@chinatelecom.cn>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Borislav Petkov <bp@alien8.de>
Cc:     Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Robert Moore <robert.moore@intel.com>,
        Len Brown <lenb@kernel.org>,
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

APEI reviewers, your input is needed here.

On Tue, Apr 5, 2022 at 8:14 AM Liu Xinpeng <liuxp11@chinatelecom.cn> wrote:
>
> record_id is in the erst_record_id_cache but not in storage,so
> erst_read will return -ENOENT, and then goto retry_next,
> erst_get_record_id_next skip a record_id. This can result in
> printing the records just in the cache.
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
> Signed-off-by: Liu Xinpeng <liuxp11@chinatelecom.cn>
> ---
>  drivers/acpi/apei/erst-dbg.c |  4 +++-
>  drivers/acpi/apei/erst.c     | 34 +++++++++++++++++++++++++++++++---
>  include/acpi/apei.h          |  1 +
>  3 files changed, 35 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/acpi/apei/erst-dbg.c b/drivers/acpi/apei/erst-dbg.c
> index c740f0faad39..5b8164280a17 100644
> --- a/drivers/acpi/apei/erst-dbg.c
> +++ b/drivers/acpi/apei/erst-dbg.c
> @@ -113,8 +113,10 @@ static ssize_t erst_dbg_read(struct file *filp, char __user *ubuf,
>  retry:
>         rc = len = erst_read(id, erst_dbg_buf, erst_dbg_buf_len);
>         /* The record may be cleared by others, try read next record */
> -       if (rc == -ENOENT)
> +       if (rc == -ENOENT) {
> +               erst_clear_cache(id);
>                 goto retry_next;
> +       }
>         if (rc < 0)
>                 goto out;
>         if (len > ERST_DBG_RECORD_LEN_MAX) {
> diff --git a/drivers/acpi/apei/erst.c b/drivers/acpi/apei/erst.c
> index 698d67cee052..07d69dc7fd62 100644
> --- a/drivers/acpi/apei/erst.c
> +++ b/drivers/acpi/apei/erst.c
> @@ -856,6 +856,31 @@ ssize_t erst_read(u64 record_id, struct cper_record_header *record,
>  }
>  EXPORT_SYMBOL_GPL(erst_read);
>
> +int erst_clear_cache(u64 record_id)
> +{
> +       int rc, i;
> +       u64 *entries;
> +
> +       if (erst_disable)
> +               return -ENODEV;
> +
> +       rc = mutex_lock_interruptible(&erst_record_id_cache.lock);
> +       if (rc)
> +               return rc;
> +
> +       entries = erst_record_id_cache.entries;
> +       for (i = 0; i < erst_record_id_cache.len; i++) {
> +               if (entries[i] == record_id)
> +                       entries[i] = APEI_ERST_INVALID_RECORD_ID;
> +       }
> +       __erst_record_id_cache_compact();
> +
> +       mutex_unlock(&erst_record_id_cache.lock);
> +
> +       return rc;
> +}
> +EXPORT_SYMBOL_GPL(erst_clear_cache);
> +
>  int erst_clear(u64 record_id)
>  {
>         int rc, i;
> @@ -998,14 +1023,17 @@ static ssize_t erst_reader(struct pstore_record *record)
>
>         len = erst_read(record_id, &rcd->hdr, rcd_len);
>         /* The record may be cleared by others, try read next record */
> -       if (len == -ENOENT)
> +       if (len == -ENOENT) {
> +               erst_clear_cache(record_id);
>                 goto skip;
> -       else if (len < 0 || len < sizeof(*rcd)) {
> +       } else if (len < 0 || len < sizeof(*rcd)) {
>                 rc = -EIO;
>                 goto out;
>         }
> -       if (!guid_equal(&rcd->hdr.creator_id, &CPER_CREATOR_PSTORE))
> +       if (!guid_equal(&rcd->hdr.creator_id, &CPER_CREATOR_PSTORE)) {
> +               erst_clear_cache(record_id);
>                 goto skip;
> +       }
>
>         record->buf = kmalloc(len, GFP_KERNEL);
>         if (record->buf == NULL) {
> diff --git a/include/acpi/apei.h b/include/acpi/apei.h
> index afaca3a075e8..f8c11ff4115a 100644
> --- a/include/acpi/apei.h
> +++ b/include/acpi/apei.h
> @@ -47,6 +47,7 @@ void erst_get_record_id_end(void);
>  ssize_t erst_read(u64 record_id, struct cper_record_header *record,
>                   size_t buflen);
>  int erst_clear(u64 record_id);
> +int erst_clear_cache(u64 record_id);
>
>  int arch_apei_enable_cmcff(struct acpi_hest_header *hest_hdr, void *data);
>  void arch_apei_report_mem_error(int sev, struct cper_sec_mem_err *mem_err);
> --
> 2.23.0
>
