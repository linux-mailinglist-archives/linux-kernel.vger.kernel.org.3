Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44755474157
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 12:18:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233529AbhLNLS3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 06:18:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231516AbhLNLS2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 06:18:28 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDF2EC061574;
        Tue, 14 Dec 2021 03:18:27 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JCwq11xYBz4xPw;
        Tue, 14 Dec 2021 22:18:21 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1639480702;
        bh=JkHhmAZ1NigU2RvvhMuaItAKWghROfy9nEo/On2PQa8=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=ncUXHFoM4iG4FsToTcGgVSlxrlTPrcsbVkQQE6BgD/h1twByADVlLw69s0K4fc8er
         w5koZXpw0PUgqdYeC8XJoCtX0Ywjya0/ax9ego1o+XCtQTbBJvdCa30cvSxXNrDmNT
         r8ReFRa4z7jYoij18LldV3u1cIL3RzFNOhqq23k9SmajeCxjP3GNmZfmbn9q92A7hp
         kODuYZ+k8Wo3Hvit1tQOLZ2krTqAC7xw7UrkdYxiXfjRF4u46IeI+E88aWI4M09+aD
         oInHcrXZlCrP/5dLvfgD4/rCOr4ZGY0h4HfH5I1gF9xb2L/mCIn8QJ6YK6IlnV2oZA
         ZqbMI5mYOrnqg==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Rob Herring <robh@kernel.org>
Cc:     John Crispin <john@phrozen.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Frank Rowand <frowand.list@gmail.com>,
        "open list:MIPS" <linux-mips@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2] of/fdt: Rework early_init_dt_scan_memory() to call
 directly
In-Reply-To: <CAL_JsqLpq7fx0pyQiJFa0P5C3JXijiVe_fr84x9RML1aDJ7vDQ@mail.gmail.com>
References: <20211208155839.4084795-1-robh@kernel.org>
 <87fsqwn03o.fsf@mpe.ellerman.id.au>
 <CAL_JsqLpq7fx0pyQiJFa0P5C3JXijiVe_fr84x9RML1aDJ7vDQ@mail.gmail.com>
Date:   Tue, 14 Dec 2021 22:18:19 +1100
Message-ID: <877dc7mo3o.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rob Herring <robh@kernel.org> writes:
> On Mon, Dec 13, 2021 at 6:47 AM Michael Ellerman <mpe@ellerman.id.au> wrote:
>> Rob Herring <robh@kernel.org> writes:
>> > Use of the of_scan_flat_dt() function predates libfdt and is discouraged
>> > as libfdt provides a nicer set of APIs. Rework
>> > early_init_dt_scan_memory() to be called directly and use libfdt.
>> ...
>> > diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
>> > index 6e1a106f02eb..63762a3b75e8 100644
>> > --- a/arch/powerpc/kernel/prom.c
>> > +++ b/arch/powerpc/kernel/prom.c
>> > @@ -532,19 +532,19 @@ static int  __init early_init_drmem_lmb(struct drmem_lmb *lmb,
>> >  }
>> >  #endif /* CONFIG_PPC_PSERIES */
>> >
>> > -static int __init early_init_dt_scan_memory_ppc(unsigned long node,
>> > -                                             const char *uname,
>> > -                                             int depth, void *data)
>> > +static int __init early_init_dt_scan_memory_ppc(void)
>> >  {
>> >  #ifdef CONFIG_PPC_PSERIES
>> > -     if (depth == 1 &&
>> > -         strcmp(uname, "ibm,dynamic-reconfiguration-memory") == 0) {
>> > +     const void *fdt = initial_boot_params;
>> > +     int node = fdt_path_offset(fdt, "/ibm,dynamic-reconfiguration-memory");
>> > +
>> > +     if (node > 0) {
>> >               walk_drmem_lmbs_early(node, NULL, early_init_drmem_lmb);
>> >               return 0;
>> >       }

It's that return that is the problem.

Now that early_init_dt_scan_memory_ppc() is only called once, that
return causes us to skip scanning regular memory nodes if there is an
"ibm,dynamic-reconfiguration-memory" property present.

So the fix is just:

diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index 1098de3b172f..125661e5fcf3 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -538,10 +538,8 @@ static int __init early_init_dt_scan_memory_ppc(void)
 	const void *fdt = initial_boot_params;
 	int node = fdt_path_offset(fdt, "/ibm,dynamic-reconfiguration-memory");
 
-	if (node > 0) {
+	if (node > 0)
 		walk_drmem_lmbs_early(node, NULL, early_init_drmem_lmb);
-		return 0;
-	}
 #endif
 	
 	return early_init_dt_scan_memory();


> The only thing I see is now there is an assumption that 'memory' nodes
> are off the root node only. Before they could be anywhere.

I don't know of any machines where that would be a problem. But given
all the wild and wonderful device trees out there, who really knows :)

Maybe we should continue to allow memory nodes to be anywhere, and print
a warning for any that aren't at the root. Then if no one reports any
hits for the warning we could switch to only allowing them at the root?

cheers


> index a835c458f50a..97d7607625ec 100644
> --- a/drivers/of/fdt.c
> +++ b/drivers/of/fdt.c
> @@ -1083,16 +1083,13 @@ int __init early_init_dt_scan_memory(void)
>         int node;
>         const void *fdt = initial_boot_params;
>
> -       fdt_for_each_subnode(node, fdt, 0) {
> -               const char *type = of_get_flat_dt_prop(node, "device_type", NULL);
> +       for (node = fdt_node_offset_by_prop_value(fdt, -1, "device_type", "memory", 6);
> +            node != -FDT_ERR_NOTFOUND;
> +            node = fdt_node_offset_by_prop_value(fdt, node, "device_type", "memory", 6)) {
>                 const __be32 *reg, *endp;
>                 int l;
>                 bool hotpluggable;
>
> -               /* We are scanning "memory" nodes only */
> -               if (type == NULL || strcmp(type, "memory") != 0)
> -                       continue;
> -
>                 reg = of_get_flat_dt_prop(node, "linux,usable-memory", &l);
>                 if (reg == NULL)
>                         reg = of_get_flat_dt_prop(node, "reg", &l);
>
> Rob
