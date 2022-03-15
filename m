Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE9924D9857
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 11:07:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346923AbiCOKIS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 06:08:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241048AbiCOKIR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 06:08:17 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F1F24D631
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 03:07:05 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 8E45668AA6; Tue, 15 Mar 2022 11:07:01 +0100 (CET)
Date:   Tue, 15 Mar 2022 11:07:01 +0100
From:   "hch@lst.de" <hch@lst.de>
To:     Sungup Moon <sungup.moon@samsung.com>
Cc:     "hch@lst.de" <hch@lst.de>, "kbusch@kernel.org" <kbusch@kernel.org>,
        "axboe@fb.com" <axboe@fb.com>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: (2) [PATCH v2] driver/nvme/host: Support duplicated nsid for
 the private ns
Message-ID: <20220315100701.GA5639@lst.de>
References: <20220315071230.GA2069@lst.de> <20220314110545epcms2p4a227eac7c4652445050e70ee2350635d@epcms2p4> <CGME20220314110545epcms2p4a227eac7c4652445050e70ee2350635d@epcms2p3> <20220315095612epcms2p304482f5160ae91a120d719c88dbe368d@epcms2p3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220315095612epcms2p304482f5160ae91a120d719c88dbe368d@epcms2p3>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 15, 2022 at 06:56:12PM +0900, Sungup Moon wrote:
> I'll answer your opinion.
> 
> 1. ns_head leak issue
> 
> I don't think that is leaked ns_head. Because although all ids and nsid are same
> through all namespaces, each namespaces are indenpendent namespace and each of that
> should have independent data structure.
> Duplicated nsid private namespace is different from the shared namespace even though
> same information.

In your patch if nvme_find_ns_head returns a head for a private namespace
with a non-uniqueue ID, that returned head already has an additional
reference, which we'll never drop as the head variable is overriden just
below.

> 2. nvme_mpath_set_disk_name issue
> 
> Yes, I also agree that subsystem-wide IDA is very important data. However, I
> implemented without nvme_mpath_set_disk_name modification at the first time, it is
> hard to decide which namespace are connected to private controller.

It is not just very important, it can't work without that.  The two
separate IDAs can will have conflicts, so you can up with two namespaces
with the same name without that change.

> As you know, each nvme controller start initiating at a time. So, each controller
> structures are sequentially initiated, but each namespaces structures are initiated
> independently because of multi-processing on cpu. So, all namespace can have different
> instance number every boot-up time, and it makes hard to track and control the private
> namespace on the controller or device failure.

Yes, but that is true of all Linux device enumeration.  That is why
everyone should use table identifiers like the UUID or GUID to identify
the namespaces.

> Anyway, the private namespace is same condition with no-multipath situation (because
> private namespace cannot shared between controllers) so I think that the private
> namespace should follow the naming rule with no-multipath situation.

We can't use the non-multipath cabale naming as it will cause conflicts
in the naming.  If anything in the system supports multipathing we have
to use subsystem based instances for the naming.
