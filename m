Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EF9D4C524A
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Feb 2022 00:52:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239671AbiBYXwr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 18:52:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbiBYXwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 18:52:44 -0500
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2659B203BF7;
        Fri, 25 Feb 2022 15:52:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1645833132; x=1677369132;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject;
  bh=tREsWWUsgvz3MJoHVqVuhwiHg2kTAvs9FHOz7isRogc=;
  b=hy6NexQEngZgQcR9xAA4ck97ZJbxwM92Z1edL24crlp6XrSVqkhmI4Iw
   NEl8YXK8A3Uehw4C+lejxw3WTK2LMYgbGcUXQfMR7AA5j8l1uM43ffS/d
   BGVO5OXF1aT0j+8oPkXDqfI+tac/RSj4m0cNTzMptJr5GwMdpPuru4fzr
   8=;
X-IronPort-AV: E=Sophos;i="5.90,137,1643673600"; 
   d="scan'208";a="197865946"
Subject: Re: [PATCH 0/2] thermal: Add support of multiple sensors
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-pdx-2a-5feb294a.us-west-2.amazon.com) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP; 25 Feb 2022 23:52:11 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-pdx-2a-5feb294a.us-west-2.amazon.com (Postfix) with ESMTPS id 1AD1B930B3;
        Fri, 25 Feb 2022 23:52:11 +0000 (UTC)
Received: from EX13D22UEA001.ant.amazon.com (10.43.61.60) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1497.28; Fri, 25 Feb 2022 23:52:04 +0000
Received: from EX13MTAUEA001.ant.amazon.com (10.43.61.82) by
 EX13D22UEA001.ant.amazon.com (10.43.61.60) with Microsoft SMTP Server (TLS)
 id 15.0.1497.28; Fri, 25 Feb 2022 23:52:03 +0000
Received: from localhost (10.106.100.12) by mail-relay.amazon.com
 (10.43.61.243) with Microsoft SMTP Server id 15.0.1497.28 via Frontend
 Transport; Fri, 25 Feb 2022 23:52:03 +0000
Date:   Fri, 25 Feb 2022 15:52:03 -0800
From:   Eduardo Valentin <eduval@amazon.com>
To:     Alexandre Bailon <abailon@baylibre.com>
CC:     <rafael@kernel.org>, <rui.zhang@intel.com>,
        <daniel.lezcano@linaro.org>, <amitk@kernel.org>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <ben.tseng@mediatek.com>, <khilman@baylibre.com>,
        <mka@chromium.org>
Message-ID: <20220225235203.GH10536@uf8f119305bce5e.ant.amazon.com>
References: <20220218084604.1669091-1-abailon@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220218084604.1669091-1-abailon@baylibre.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-14.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Alexandre,

On Fri, Feb 18, 2022 at 09:46:02AM +0100, Alexandre Bailon wrote:
> CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you can confirm the sender and know the content is safe.
> 
> 
> 
> Following this comment [1], this updates thermal_of to support multiple
> sensors.
> 
> This has some limitations:
> - A sensor must have its own termal zone, even if it is also registered
>   inside a thermal zone supporting multiple sensors.
> - Some callbacks (such as of_thermal_set_trips) have been updated to support
>   multiple sensors but I don't know if this really make sense.
> - of_thermal_get_trend have not been updated to support multiple sensors.
>   This would probably make sense to support it but I am not sure how to do it,
>   especially for the average.

Great to see this having somewhat a form now!

Overall the idea is sane and aligned to what I had in mind back during the 2019 Linux plumbers: one thermal zone should have multiple sensor inputs.
https://lpc.events/event/4/page/34-accepted-microconferences#PMSummary

In fact, that is aligned to what I originally wrote in the thermal device tree bindings:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/thermal/thermal-zones.yaml#n79

The only major concern with your series is the usage of of-thermal to achieve the multiple sensors per thermal zone.
While that solves the problem, it has the following limitations:
(1) limited to devices described in device tree. everybody else is left out.
(2) it keeps extending the code duplication in of-thermal. 

My suggestion here is have the thermal core aware of the multiple sensors per thermal zone.

That has the advantage of:
(a) cleanup the sensor handling within of-thermal
(b) expand the multi sensor per zone to all types of thermal drivers
(c) standardize the way to handle the multi sensor.

In my original thoughts of achieving this would have include:
(i) move the sensor handling part to a specific c file within the thermal core. That would include helper functions to execute the aggregations, max, min, avg, geo avg, etc etc
(ii) a way to tell what sensors are being aggregated via sysfs, probably a simple syslink to the original device would suffice
(iii) a way to change the aggregation via sysfs. just like you proposed a way to specify the aggregation via device tree, we should have a way to specify the aggregation at runtime.
(iv) once (i)-(iii) is done, you basically cleanup of-thermal to use the new C api written, and of-thermal simply use the API created to register the sensors. I d expect that all the callbacks related sensor ops would disappear from of-thermal.

> 
> [1]: https://patchwork.kernel.org/comment/24723927/
> 
> Alexandre Bailon (2):
>   dt-bindings: thermal: Update the bindings to support multiple sensor
>   Thermal: Add support of multi sensor
> 
>  .../bindings/thermal/thermal-zones.yaml       |  20 +-
>  drivers/thermal/thermal_of.c                  | 491 +++++++++++++++---
>  2 files changed, 449 insertions(+), 62 deletions(-)
> 
> --
> 2.34.1
> 

-- 
All the best,
Eduardo Valentin
