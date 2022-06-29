Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C85E560531
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 18:03:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233015AbiF2QCd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 12:02:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234085AbiF2QCH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 12:02:07 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 149D93D1F0;
        Wed, 29 Jun 2022 09:01:38 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.0.0)
 id ab44a7ba5fefe840; Wed, 29 Jun 2022 18:01:36 +0200
Received: from kreacher.localnet (unknown [213.134.175.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id E2A5A66C9F3;
        Wed, 29 Jun 2022 18:01:35 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Peter Wang <peter.wang@mediatek.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] PM-runtime: Check supplier_preactivated before release supplier
Date:   Wed, 29 Jun 2022 18:01:35 +0200
Message-ID: <12028598.O9o76ZdvQC@kreacher>
In-Reply-To: <CAJZ5v0gTpv2gt_Gm9rUd+8Jmp4=ij2=J20o7qO0sC-hm=w3=_A@mail.gmail.com>
References: <20220613120755.14306-1-peter.wang@mediatek.com> <b55d5691-0b2d-56bb-26ff-dcac56770611@mediatek.com> <CAJZ5v0gTpv2gt_Gm9rUd+8Jmp4=ij2=J20o7qO0sC-hm=w3=_A@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.175.150
X-CLIENT-HOSTNAME: 213.134.175.150
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvfedrudegledgleehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppedvudefrddufeegrddujeehrdduhedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvddufedrudefgedrudejhedrudehtddphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohephedprhgtphhtthhopehpvghtvghrrdifrghnghesmhgvughirghtvghkrdgtohhmpdhrtghpthhtoheprhgrfhgrvghlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehgrhgvghhkhheslhhinhhugihfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhig
 qdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-DCC--Metrics: v370.home.net.pl 1024; Body=5 Fuz1=5 Fuz2=5
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Add CCs to linix-pm, LKML and Greg]

On Wednesday, June 29, 2022 5:32:00 PM CEST Rafael J. Wysocki wrote:
> On Wed, Jun 29, 2022 at 4:47 PM Peter Wang <peter.wang@mediatek.com> wrote:
> >
> >
> > On 6/29/22 9:22 PM, Rafael J. Wysocki wrote:
> > > On Wed, Jun 29, 2022 at 5:02 AM Peter Wang <peter.wang@mediatek.com> wrote:
> > >>
> > >> On 6/28/22 11:54 PM, Rafael J. Wysocki wrote:
> > >>> On Tue, Jun 28, 2022 at 3:53 AM Peter Wang <peter.wang@mediatek.com> wrote:
> > >>>> On 6/28/22 3:00 AM, Rafael J. Wysocki wrote:
> > >>>>> On Mon, Jun 13, 2022 at 2:08 PM <peter.wang@mediatek.com> wrote:
> > >>>>>> From: Peter Wang <peter.wang@mediatek.com>
> > >>>>>>
> > >>>>>> With divice link of DL_FLAG_PM_RUNTIME, if consumer call pm_runtime_get_suppliers
> > >>>>>> to prevent supplier enter suspend, pm_runtime_release_supplier should
> > >>>>>> check supplier_preactivated before let supplier enter suspend.
> > >>>>> Why?
> > >>>> because supplier_preactivated is true means supplier cannot enter
> > >>>> suspend, right?
> > >>> No, it doesn't mean that.
> > >> Hi Rafael,
> > >>
> > >> if supplier_preactivated is true, means someone call
> > >> pm_runtime_get_suppliers and
> > >> before pm_runtime_put_suppliers right? This section suppliers should not
> > >> enter suspend.
> > > No, this is not how this is expected to work.
> > >
> > > First off, the only caller of pm_runtime_get_suppliers() and
> > > pm_runtime_put_suppliers() is __driver_probe_device().  Really nobody
> > > else has any business that would require calling them.
> > Hi Rafael,
> >
> > Yes, you are right!
> > __driver_probe_device the only one use and just because
> > __driver_probe_device use
> > pm_runtime_get_suppliers cause problem.
> >
> >
> > > Second, the role of pm_runtime_get_suppliers() is to "preactivate" the
> > > suppliers before running probe for a consumer device and the role of
> >
> > the role of pm_runtime_get_suppliers() is to "preactivate" the suppliers,
> > but suppliers may suspend immediately after preactivate right?
> > Here is just this case. this is first racing point.
> > Thread A: pm_runtime_get_suppliers                -> __driver_probe_device
> > Thread B: pm_runtime_release_supplier
> > Thread A: Run with supplier not preactivate      -> __driver_probe_device
> >
> > > pm_runtime_put_suppliers() is to do the cleanup in case the device is
> > > left in suspend after probing.
> > >
> > > IOW, pm_runtime_get_suppliers() is to ensure that the suppliers will
> > > be active until the probe callback takes over and the rest depends on
> > > that callback.
> >
> > The problem of this racing will finally let consumer is active but
> > supplier is suspended.
> 
> So it would be better to send a bug report regarding this.
> 
> > The link relation is broken.
> > I know you may curious how it happened? right?
> > Honestly, I am not sure, but I think the second racing point
> > is rpm_get_suppliers and pm_runtime_put_suppliers(release rpm_active).
> 
> I'm not sure what you mean by "the racing point".
> 
> Yes, these functions can run concurrently.
> 
> > So, I try to fix the first racing point and the problem is gone.
> > It is full meet expect, and the pm runtime will work smoothly after
> > __driver_probe_device done.
> 
> I'm almost sure that there is at least one scenario that would be
> broken by this change.

That said, the code in there may be a bit overdesigned.

Does the patch below help?

---
 drivers/base/power/runtime.c |   14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

Index: linux-pm/drivers/base/power/runtime.c
===================================================================
--- linux-pm.orig/drivers/base/power/runtime.c
+++ linux-pm/drivers/base/power/runtime.c
@@ -1768,7 +1768,6 @@ void pm_runtime_get_suppliers(struct dev
 		if (link->flags & DL_FLAG_PM_RUNTIME) {
 			link->supplier_preactivated = true;
 			pm_runtime_get_sync(link->supplier);
-			refcount_inc(&link->rpm_active);
 		}
 
 	device_links_read_unlock(idx);
@@ -1788,19 +1787,8 @@ void pm_runtime_put_suppliers(struct dev
 	list_for_each_entry_rcu(link, &dev->links.suppliers, c_node,
 				device_links_read_lock_held())
 		if (link->supplier_preactivated) {
-			bool put;
-
 			link->supplier_preactivated = false;
-
-			spin_lock_irq(&dev->power.lock);
-
-			put = pm_runtime_status_suspended(dev) &&
-			      refcount_dec_not_one(&link->rpm_active);
-
-			spin_unlock_irq(&dev->power.lock);
-
-			if (put)
-				pm_runtime_put(link->supplier);
+			pm_runtime_put(link->supplier);
 		}
 
 	device_links_read_unlock(idx);



