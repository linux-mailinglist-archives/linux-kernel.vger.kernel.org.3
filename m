Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BFE451B768
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 07:19:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243338AbiEEFXA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 01:23:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243252AbiEEFWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 01:22:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E46D1FA45
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 22:19:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EFCF4B8293D
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 05:19:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FC29C385A4;
        Thu,  5 May 2022 05:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651727953;
        bh=CjoysTt4smiT9cYHZROxtXKWyaDUyxzXOQTicMbEYJU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=n7DaK2CI4XjVWFu0mBhCxA8nTRXbsnYsLE53Sp0Nj5ggzrg30/mJGosd00h2nYW6D
         J2TVSCGAuewrgjBy2zlMVTpLCF4P+K2Kh+IenApMvT9Vv1eiJYZBt3BFEdt7x2/Ih3
         4gtJrtifNcw3rP9p/FsHVL0iaakh2aHmnrgjmZTds5cP2kqgbD73XiS9qdCFERz7ws
         IV5PugUFqaYY1m6E+AZAVr5kNEyiMgFOAq3z5QBwcHRTAO3D7LGd4fUCw9h+mlhFMy
         yF4JfnNicUltgXoA8kF8pN/793dvYBSAusMngCWCe7ENNTUUGNE/6kLMGkcsA6LaxQ
         L9cUoKOV5jxcw==
Date:   Wed, 4 May 2022 22:19:10 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc:     linux@leemhuis.info,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-nvme@lists.infradead.org, luto@kernel.org
Subject: Re: [BUG][5.18rc5] nvme nvme0: controller is down; will reset:
 CSTS=0xffffffff, PCI_STATUS=0x10
Message-ID: <YnNeTsSzFJqEK/s+@kbusch-mbp.dhcp.thefacebook.com>
References: <CABXGCsMiKe31UaoMV02gW4iJSKnBiO5jGQKej=Zem24mD0ObQw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABXGCsMiKe31UaoMV02gW4iJSKnBiO5jGQKej=Zem24mD0ObQw@mail.gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 05, 2022 at 06:58:11AM +0500, Mikhail Gavrilov wrote:
> ps    1 : mp:7.10W operational enlat:0 exlat:0 rrt:1 rrl:1
>           rwt:1 rwl:1 idle_power:- active_power:-
> ps    2 : mp:5.20W operational enlat:0 exlat:0 rrt:2 rrl:2
>           rwt:2 rwl:2 idle_power:- active_power:-
> ps    3 : mp:0.0620W non-operational enlat:2500 exlat:7500 rrt:3 rrl:3
>           rwt:3 rwl:3 idle_power:- active_power:-
> ps    4 : mp:0.0440W non-operational enlat:10500 exlat:65000 rrt:4 rrl:4
>           rwt:4 rwl:4 idle_power:- active_power:-
> 
> # cat /sys/module/nvme_core/parameters/default_ps_max_latency_us
> 100000
> 
> I concluded that my problem is not related to APST because 2500 + 7500
> + 10500 + 65000 = 85500 < 100000
> 100000 is greater than the total latency of any state (enlat + xlat).
> 
> Or am I misinterpreting the results?

I think you did misinterpret the results. The max latency just says which power
state is the deepest it will request APST, and your controller's reported
values will allow the deepest low power state your controller supports, which
is known to cause problems with some platform/controller combinations.

The troubleshooting steps for your observation is to:

  1. Turn off APST (nvme_core.default_ps_max_latency_us=0)
  2. Turn off APSM (pcie_aspm=off)
  3. Turn off both

Typically one of those resolves the issue.
