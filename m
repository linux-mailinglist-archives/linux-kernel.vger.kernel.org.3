Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74826546D59
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 21:40:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348504AbiFJTkU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 15:40:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244754AbiFJTkS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 15:40:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12FA913CE7;
        Fri, 10 Jun 2022 12:40:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9076F62257;
        Fri, 10 Jun 2022 19:40:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD39DC34114;
        Fri, 10 Jun 2022 19:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654890013;
        bh=zY9K48Wzf+bR6A+FphTRaq1q/xR6y1r0z0sAqv0T5uE=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=DIrVoJAhxUYKXBermpVlKPKEyyF4wjggIpzrsuBu60nGoDQAeB4UWFVgBgUwAYQk0
         v6Omn4T2YqHyeFlKKbmnchnI9Zu6ADvZGLaU/yr+GWzT/ZmHFnA9YsElmu/4c8TInP
         +8rP+Pj0AYEINgYFx30+3G8HrTahJQrz5Kz8pUaoj8Bc9SdpQdQ9c7oQlh/17Tn8tM
         LFfPKXx+4F93TQVEnHfJkdvFMfS5Wjnfw410OmZXLYkEIAnfte2PzK4idKr8sPLXH7
         m0SnWsdjc6hRBvdO4OLO2Py0QKzFE/b/gN9IXBZfcYNof3owLT3aV19bfoBFlIXOvh
         8udCv1wmvGBEA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAEXpiVQihEadxsNodarz2-wxSAipfpzEaA8zKpnozszC+weYTQ@mail.gmail.com>
References: <CAEXpiVQihEadxsNodarz2-wxSAipfpzEaA8zKpnozszC+weYTQ@mail.gmail.com>
Subject: Re: [PATCH 5.4] Common clock: =?utf-8?b?4oCL4oCLVG8=?= list active consumers of clocks
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     chinmoyghosh2001@gmail.com, mintupatel89@gmail.com
To:     Vishal Badole <badolevishal1116@gmail.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        mturquette@baylibre.com
Date:   Fri, 10 Jun 2022 12:40:11 -0700
User-Agent: alot/0.10
Message-Id: <20220610194013.DD39DC34114@smtp.kernel.org>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Why "5.4" in the subject?

Quoting Vishal Badole (2022-05-31 11:28:35)
> This feature lists the name of clocks and their consumer devices. This
> debug feature can be used to check the active clocks and the devices who
> have enabled them.
>=20
> for example:
> debian@beaglebone:~$ cat /sys/kernel/debug/clk/clk_devices_name
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 clock_name =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0devices_name
> =C2=A0 =C2=A0 =C2=A0 ----------------
> -------------------------------------------------------------------------
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0l4-wkup-clkctrl:0008:0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A044e07000.target-module
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 l4l=
s-clkctrl:0074:0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A04804c000.t=
arget-module
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 l4l=
s-clkctrl:0058:0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A048311fe0.t=
arget-module
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0l4-rtc-clkc=
trl:0000:0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A044e3e074.target-=
module
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0=C2=A0 =C2=A0clk_32768_ck =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0=20
> 44e3e000.rtc
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 l4ls=
-clkctrl:00d8:0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0480c8000.ta=
rget-module
> =C2=A0 =C2=A0cpsw-125mhz-clkctrl:0014:0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A04a101200.target-module
>=20
> Signed-off-by: Vishal Badole <badolevishal1116@gmail.com>
> Signed-off-by: Chinmoy Ghosh <chinmoyghosh2001@gmail.com>
> Signed-off-by: Mintu Patel <mintupatel89@gmail.com>
> Signed-off-by: Vimal Kumar <vimal.kumar32@gmail.com>

Where are the Co-developed-by tags? Also, your SoB should be last.

> ---
> =C2=A0drivers/clk/Kconfig | =C2=A0 8 ++++
> =C2=A0drivers/clk/clk.c =C2=A0 | 120 ++++++++++++++++++++++++++++++++++++=
+++++++++++++++-
> =C2=A02 files changed, 127 insertions(+), 1 deletion(-)

The patch is malformed. Not sure what's happening with your MUA.

>=20
> diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
> index c44247d..549cdda 100644
> --- a/drivers/clk/Kconfig
> +++ b/drivers/clk/Kconfig
> @@ -23,6 +23,14 @@ config COMMON_CLK
> =C2=A0menu "Common Clock Framework"
> =C2=A0 depends on COMMON_CLK
> =C2=A0
> +config DEBUG_CLK_CONSUMER
> + bool "Debug feature to list clocks and their active consumers"

Don't think we need a new config for this. Just add it to the existing
CONFIG_DEBUGFS area.

> + depends on DEBUG_FS && COMMON_CLK
> + help
> + =C2=A0Clock consumer debug feature supports for clock debugging. Chose y
> + =C2=A0to get debug entry in file system to list clocks and their active
> + =C2=A0consumer devices.
> +
> =C2=A0config COMMON_CLK_WM831X
> =C2=A0 tristate "Clock driver for WM831x/2x PMICs"
> =C2=A0 depends on MFD_WM831X
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index 13332f8..dccbd35 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -105,6 +105,84 @@ struct clk {
> =C2=A0 struct hlist_node clks_node;
> =C2=A0};
> =C2=A0
> +#ifdef CONFIG_DEBUG_CLK_CONSUMER
> +/*Linked List Node*/
> +struct clk_dev_list {
> + struct list_head list;
> + const char *clk_name;
> + const char *dev_name;
> +};
> +
> +/*Declare and init the head node of the linked list*/
> +LIST_HEAD(head_node);
> +
> +static void clk_dev_entry(struct clk *clk_ptr)
> +{
> + struct clk_dev_list *new_node_ptr =3D NULL;
> + struct clk_dev_list *temp_node_ptr =3D NULL;
> + int repeat_count =3D 0;
> + static bool is_first_node;
> + const char *clk_name_ptr =3D NULL;
> + const char *dev_name_ptr =3D NULL;
> +
> + if (clk_ptr->dev) {
> + dev_name_ptr =3D dev_name(clk_ptr->dev);
> +
> + clk_name_ptr =3D clk_ptr->core->name;
> +
> + if (is_first_node) {
> + /* Iterate the list to check duplicate entry */
> + list_for_each_entry(temp_node_ptr, &head_node, list) {
> + if (temp_node_ptr->clk_name =3D=3D clk_name_ptr &&
> + =C2=A0 =C2=A0temp_node_ptr->dev_name =3D=3D dev_name_ptr) {
> + repeat_count++;
> + break;
> + }
> + }
> + }
> +
> + is_first_node =3D 1;
> +
> + if (!repeat_count && clk_ptr->core->enable_count) {
> + /*Creating Node*/
> + new_node_ptr =3D kmalloc(sizeof(*new_node_ptr),
> + =C2=A0 =C2=A0 =C2=A0 GFP_KERNEL);
> + if (!new_node_ptr)
> + return;
> +
> + /*Assgin the data that is received*/

Typo in Assign.

> + new_node_ptr->clk_name =3D clk_name_ptr;
> + new_node_ptr->dev_name =3D dev_name_ptr;
> +
> + /*Init the list within the struct*/
> + INIT_LIST_HEAD(&new_node_ptr->list);
> +
> + /*Add Node to Linked List*/
> + list_add_tail(&new_node_ptr->list, &head_node);
> + }
> + }
> +}
> +
> +/* Function to remove the clk and device entry */
> +static void clk_dev_dentry(struct clk *clk)
> +{
> + struct clk_dev_list *temp_node_ptr =3D NULL;
> + struct clk_dev_list *cur_node_ptr =3D NULL;
> +
> + if (clk->dev) {
> + /* Go through the list and free the memory */
> + list_for_each_entry_safe(cur_node_ptr, temp_node_ptr,
> + &head_node, list) {
> + if (cur_node_ptr->clk_name =3D=3D clk->core->name &&
> + =C2=A0 =C2=A0cur_node_ptr->dev_name =3D=3D dev_name(clk->dev)) {
> + list_del(&cur_node_ptr->list);
> + kfree(cur_node_ptr);
> + }
> + }
> + }
> +}
> +#endif
> +
> =C2=A0/*** =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 runtime pm =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0***/
> =C2=A0static int clk_pm_runtime_get(struct clk_core *core)
> =C2=A0{
> @@ -1020,6 +1098,9 @@ void clk_disable(struct clk *clk)
> =C2=A0 return;
> =C2=A0
> =C2=A0 clk_core_disable_lock(clk->core);
> +#ifdef CONFIG_DEBUG_CLK_CONSUMER
> + clk_dev_dentry(clk);
> +#endif
> =C2=A0}
> =C2=A0EXPORT_SYMBOL_GPL(clk_disable);
> =C2=A0
> @@ -1181,10 +1262,21 @@ EXPORT_SYMBOL_GPL(clk_restore_context);
> =C2=A0 */
> =C2=A0int clk_enable(struct clk *clk)
> =C2=A0{
> +#ifdef CONFIG_DEBUG_CLK_CONSUMER
> + int ret =3D 0;
> +#endif
> =C2=A0 if (!clk)
> =C2=A0 return 0;
> =C2=A0
> +#ifndef CONFIG_DEBUG_CLK_CONSUMER
> =C2=A0 return clk_core_enable_lock(clk->core);
> +#else
> + ret =3D clk_core_enable_lock(clk->core);
> + if (!ret)
> + clk_dev_entry(clk);
> +
> + return ret;
> +#endif

Not sure what this is doing.

> =C2=A0}
> =C2=A0EXPORT_SYMBOL_GPL(clk_enable);
> =C2=A0
> @@ -2986,6 +3078,29 @@ static void clk_dump_one(struct seq_file *s, struct
> clk_core *c, int level)
> =C2=A0 =C2=A0 clk_core_get_scaled_duty_cycle(c, 100000));
> =C2=A0}
> =C2=A0
> +#ifdef CONFIG_DEBUG_CLK_CONSUMER
> +static int clk_devices_show(struct seq_file *s, void *data)
> +{
> + struct clk_dev_list *clk_dev_node;
> +
> + seq_puts(s, " =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0clock_name =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
> =C2=A0devices_name\n");
> + seq_puts(s,
> "------------------------------------------------------------------------=
-\n");
> +
> + clk_prepare_lock();
> +
> + /*Traversing Linked List and Print its Members*/
> + list_for_each_entry(clk_dev_node, &head_node, list) {

It's hard to read but we already have a list of all clk consumers for a
clk_hw pointer, see clk_core_link_consumer(). And we stash the device
consuming it with clk_hw_create_clk(). That should be sufficient.


> + seq_printf(s, "%35s %35s\n", clk_dev_node->clk_name,
> + =C2=A0 clk_dev_node->dev_name);
> + }
> +
> + clk_prepare_unlock();
> +
> + return 0;
> +}
> +DEFINE_SHOW_ATTRIBUTE(clk_devices);
> +#endif
> +
> =C2=A0static void clk_dump_subtree(struct seq_file *s, struct clk_core *c=
, int
> level)
> =C2=A0{
> =C2=A0 struct clk_core *child;
> @@ -3256,7 +3371,10 @@ static int __init clk_debug_init(void)
> =C2=A0 =C2=A0 =C2=A0&clk_summary_fops);
> =C2=A0 debugfs_create_file("clk_orphan_dump", 0444, rootdir, &orphan_list,
> =C2=A0 =C2=A0 =C2=A0&clk_dump_fops);
> -
> +#ifdef CONFIG_DEBUG_CLK_CONSUMER
> + debugfs_create_file("clk_devices_name", 0444, rootdir, NULL,

Call it 'clk_consumers' please.

> + =C2=A0 =C2=A0&clk_devices_fops);
