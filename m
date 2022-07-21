Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F82557C82C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 11:54:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232812AbiGUJyW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 05:54:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbiGUJyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 05:54:19 -0400
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A21A81B04;
        Thu, 21 Jul 2022 02:54:18 -0700 (PDT)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-31e560aa854so11469737b3.6;
        Thu, 21 Jul 2022 02:54:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iTJfNbacNs72Ij4X/S7T9wZZgS4I9cYRvxKbLI1wpAs=;
        b=YnpSd7KKl/Z0xpMNKUGkW8s7zl139mC87bQ2zNAf15TzhQOQNSmDF0u5EZYCbJslmt
         UcZC8s3Sfoms887MG6OnhVev9WD6NDvdnBn+owWRJa6tsC65fhSre1QX0Y3ir5dvN/Nr
         aYTd8Pn7pRNMIb8Y6ZFgYpD/ncohtCa/e6XoR2JRV6e6OpaKpk0lKahMTQvbXRv0JkIN
         UAv3q8Hk59d+87d/CyN1gMb6yoTraYc5SA/BVqOQl4C6/54AoMtYl/9n7wSW9av5JqWA
         35uInn/S9lL+0TPQOZ2Smq7M2k5MCg6L0gLbr/Pgl0lA8x4wUY+tat7OckzDZaYRyk5g
         KuHg==
X-Gm-Message-State: AJIora9q0c0UULaokglkdWB7ypCKSU50vn5dRHRn2Qi3p5hPQylxjV9b
        hbHrz+auw1klk1607OfGuDPWSx5DmZr5sNoLsbg=
X-Google-Smtp-Source: AGRyM1tGJGvJH4lyIFuh4q9T0AcAsnMIfyWz0d7qz0qCCso3kBQcxWQBTlIfYJvS/hWYgsjCDGac9oVZPnBiFYj4OUc=
X-Received: by 2002:a81:89c3:0:b0:31e:6908:f857 with SMTP id
 z186-20020a8189c3000000b0031e6908f857mr8348503ywf.149.1658397257668; Thu, 21
 Jul 2022 02:54:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220720-arch_topo_fixes-v3-0-43d696288e84@arm.com> <20220720-arch_topo_fixes-v3-2-43d696288e84@arm.com>
In-Reply-To: <20220720-arch_topo_fixes-v3-2-43d696288e84@arm.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 21 Jul 2022 11:54:05 +0200
Message-ID: <CAJZ5v0jizZELraQsS0gP0ALL60wyhT2F-7no5p5KKmg7Spi6uw@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] ACPI: PPTT: Leave the table mapped for the runtime usage
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Pierre Gondois <pierre.gondois@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Guenter Roeck <linux@roeck-us.net>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Ionela Voinescu <ionela.voinescu@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 20, 2022 at 2:56 PM Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> Currently, everytime an information needs to be fetched from the PPTT,
> the table is mapped via acpi_get_table() and unmapped after the use via
> acpi_put_table() which is fine. However we do this at runtime especially
> when the CPU is hotplugged out and plugged in back since we re-populate
> the cache topology and other information.
>
> However, with the support to fetch LLC information from the PPTT in the
> cpuhotplug path which is executed in the atomic context, it is preferred
> to avoid mapping and unmapping of the PPTT for every single use as the
> acpi_get_table() might sleep waiting for a mutex.
>
> In order to avoid the same, the table is needs to just mapped once on
> the boot CPU and is never unmapped allowing it to be used at runtime
> with out the hassle of mapping and unmapping the table.
>
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Cc: Rafael J. Wysocki <rafael@kernel.org>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
>
> --
>
> Hi Rafael,
>
> Sorry to bother you again on this PPTT changes. Guenter reported an issue
> with lockdep enabled in -next that include my cacheinfo/arch_topology changes
> to utilise LLC from PPTT in the CPU hotplug path.
>
> Please ack the change once you are happy so that I can get it merged with
> other fixes via Greg's tree.

OK

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

>
> diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
> index dd3222a15c9c..c91342dcbcd6 100644
> --- a/drivers/acpi/pptt.c
> +++ b/drivers/acpi/pptt.c
> @@ -533,21 +533,37 @@ static int topology_get_acpi_cpu_tag(struct acpi_table_header *table,
>         return -ENOENT;
>  }
>
> +
> +static struct acpi_table_header *acpi_get_pptt(void)
> +{
> +       static struct acpi_table_header *pptt;
> +       acpi_status status;
> +
> +       /*
> +        * PPTT will be used at runtime on every CPU hotplug in path, so we
> +        * don't need to call acpi_put_table() to release the table mapping.
> +        */
> +       if (!pptt) {
> +               status = acpi_get_table(ACPI_SIG_PPTT, 0, &pptt);
> +               if (ACPI_FAILURE(status))
> +                       acpi_pptt_warn_missing();
> +       }
> +
> +       return pptt;
> +}
> +
>  static int find_acpi_cpu_topology_tag(unsigned int cpu, int level, int flag)
>  {
>         struct acpi_table_header *table;
> -       acpi_status status;
>         int retval;
>
> -       status = acpi_get_table(ACPI_SIG_PPTT, 0, &table);
> -       if (ACPI_FAILURE(status)) {
> -               acpi_pptt_warn_missing();
> +       table = acpi_get_pptt();
> +       if (!table)
>                 return -ENOENT;
> -       }
> +
>         retval = topology_get_acpi_cpu_tag(table, cpu, level, flag);
>         pr_debug("Topology Setup ACPI CPU %d, level %d ret = %d\n",
>                  cpu, level, retval);
> -       acpi_put_table(table);
>
>         return retval;
>  }
> @@ -568,16 +584,13 @@ static int find_acpi_cpu_topology_tag(unsigned int cpu, int level, int flag)
>  static int check_acpi_cpu_flag(unsigned int cpu, int rev, u32 flag)
>  {
>         struct acpi_table_header *table;
> -       acpi_status status;
>         u32 acpi_cpu_id = get_acpi_id_for_cpu(cpu);
>         struct acpi_pptt_processor *cpu_node = NULL;
>         int ret = -ENOENT;
>
> -       status = acpi_get_table(ACPI_SIG_PPTT, 0, &table);
> -       if (ACPI_FAILURE(status)) {
> -               acpi_pptt_warn_missing();
> -               return ret;
> -       }
> +       table = acpi_get_pptt();
> +       if (!table)
> +               return -ENOENT;
>
>         if (table->revision >= rev)
>                 cpu_node = acpi_find_processor_node(table, acpi_cpu_id);
> @@ -585,8 +598,6 @@ static int check_acpi_cpu_flag(unsigned int cpu, int rev, u32 flag)
>         if (cpu_node)
>                 ret = (cpu_node->flags & flag) != 0;
>
> -       acpi_put_table(table);
> -
>         return ret;
>  }
>
> @@ -605,18 +616,15 @@ int acpi_find_last_cache_level(unsigned int cpu)
>         u32 acpi_cpu_id;
>         struct acpi_table_header *table;
>         int number_of_levels = 0;
> -       acpi_status status;
> +
> +       table = acpi_get_pptt();
> +       if (!table)
> +               return -ENOENT;
>
>         pr_debug("Cache Setup find last level CPU=%d\n", cpu);
>
>         acpi_cpu_id = get_acpi_id_for_cpu(cpu);
> -       status = acpi_get_table(ACPI_SIG_PPTT, 0, &table);
> -       if (ACPI_FAILURE(status)) {
> -               acpi_pptt_warn_missing();
> -       } else {
> -               number_of_levels = acpi_find_cache_levels(table, acpi_cpu_id);
> -               acpi_put_table(table);
> -       }
> +       number_of_levels = acpi_find_cache_levels(table, acpi_cpu_id);
>         pr_debug("Cache Setup find last level level=%d\n", number_of_levels);
>
>         return number_of_levels;
> @@ -638,20 +646,16 @@ int acpi_find_last_cache_level(unsigned int cpu)
>  int cache_setup_acpi(unsigned int cpu)
>  {
>         struct acpi_table_header *table;
> -       acpi_status status;
> -
> -       pr_debug("Cache Setup ACPI CPU %d\n", cpu);
>
> -       status = acpi_get_table(ACPI_SIG_PPTT, 0, &table);
> -       if (ACPI_FAILURE(status)) {
> -               acpi_pptt_warn_missing();
> +       table = acpi_get_pptt();
> +       if (!table)
>                 return -ENOENT;
> -       }
> +
> +       pr_debug("Cache Setup ACPI CPU %d\n", cpu);
>
>         cache_setup_acpi_cpu(table, cpu);
> -       acpi_put_table(table);
>
> -       return status;
> +       return 0;
>  }
>
>  /**
> @@ -730,50 +734,38 @@ int find_acpi_cpu_topology_package(unsigned int cpu)
>  int find_acpi_cpu_topology_cluster(unsigned int cpu)
>  {
>         struct acpi_table_header *table;
> -       acpi_status status;
>         struct acpi_pptt_processor *cpu_node, *cluster_node;
>         u32 acpi_cpu_id;
>         int retval;
>         int is_thread;
>
> -       status = acpi_get_table(ACPI_SIG_PPTT, 0, &table);
> -       if (ACPI_FAILURE(status)) {
> -               acpi_pptt_warn_missing();
> +       table = acpi_get_pptt();
> +       if (!table)
>                 return -ENOENT;
> -       }
>
>         acpi_cpu_id = get_acpi_id_for_cpu(cpu);
>         cpu_node = acpi_find_processor_node(table, acpi_cpu_id);
> -       if (cpu_node == NULL || !cpu_node->parent) {
> -               retval = -ENOENT;
> -               goto put_table;
> -       }
> +       if (!cpu_node || !cpu_node->parent)
> +               return -ENOENT;
>
>         is_thread = cpu_node->flags & ACPI_PPTT_ACPI_PROCESSOR_IS_THREAD;
>         cluster_node = fetch_pptt_node(table, cpu_node->parent);
> -       if (cluster_node == NULL) {
> -               retval = -ENOENT;
> -               goto put_table;
> -       }
> +       if (!cluster_node)
> +               return -ENOENT;
> +
>         if (is_thread) {
> -               if (!cluster_node->parent) {
> -                       retval = -ENOENT;
> -                       goto put_table;
> -               }
> +               if (!cluster_node->parent)
> +                       return -ENOENT;
> +
>                 cluster_node = fetch_pptt_node(table, cluster_node->parent);
> -               if (cluster_node == NULL) {
> -                       retval = -ENOENT;
> -                       goto put_table;
> -               }
> +               if (!cluster_node)
> +                       return -ENOENT;
>         }
>         if (cluster_node->flags & ACPI_PPTT_ACPI_PROCESSOR_ID_VALID)
>                 retval = cluster_node->acpi_processor_id;
>         else
>                 retval = ACPI_PTR_DIFF(cluster_node, table);
>
> -put_table:
> -       acpi_put_table(table);
> -
>         return retval;
>  }
>
>
> --
> b4 0.10.0-dev-54fef
