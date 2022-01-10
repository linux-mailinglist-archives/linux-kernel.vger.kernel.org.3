Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05CE448A010
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 20:23:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242674AbiAJTXi convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 10 Jan 2022 14:23:38 -0500
Received: from mail-qt1-f172.google.com ([209.85.160.172]:37744 "EHLO
        mail-qt1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232564AbiAJTXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 14:23:30 -0500
Received: by mail-qt1-f172.google.com with SMTP id c15so15181944qtc.4;
        Mon, 10 Jan 2022 11:23:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=VUlGWfUIe9aP4prpdN6w8vuIMt/wRh4HY7X8hkjAKng=;
        b=SU2O8DRHo4RBR6IGj2Pd69VNaus7vG903cQo70vDgyV1oRrh6yE+ktxnxJTWuPKx5E
         HU32xF1LXnh6LDlSK4tClBUT3CM1e6XpyDXmDKNciVsvFHq1KziCxAPj4ykQ1menzE3g
         h5BokLQuNn8D473rneCsCpc2+heaqkBDAJb0+qYykZh+yekiixkRrbeCvM+UBscrmK2k
         0R8HSk0nicLyxnq8qR7laggGqUn2nsC3oc/zDHCitY66rQAknR84048rgIUl6OMIUlFv
         +Xeuv+h1Ybu+RIK9iwb8EjHyHk0zawQ/gt8oXhMzLh6FYW59TIFAtK9LvsqGgvJt1YgK
         KneA==
X-Gm-Message-State: AOAM532BAA8Fjy4PWhpID3/3mBeiIVJKsxGpJwif9kgsdA0IEYo/c/C1
        IQGmAxHZl34e4Q2eEZYz3fyJB0+oq4laFu9EXc2TWVZASSM=
X-Google-Smtp-Source: ABdhPJxFB6tz8rU5eFsRQ6i/z8LM24BF+08KGQ/Tepmg2o6C0SFuAI5Q+9Kd7MvFxe+wL75fdEF3iU63LY+JuWq6qzc=
X-Received: by 2002:a05:622a:c8:: with SMTP id p8mr1031383qtw.80.1641842609715;
 Mon, 10 Jan 2022 11:23:29 -0800 (PST)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 10 Jan 2022 20:23:18 +0100
Message-ID: <CAJZ5v0h20TNyM9MW2UCPg4u=3hBRxZH+f91GSxxP0V0m0Nf1ow@mail.gmail.com>
Subject: [GIT PULL] Device properties framework updates for v5.17-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 devprop-5.17-rc1

with top-most commit 3a571fc19673bc00c36b2cd8a2b9811c013115d7

 software node: Update MAINTAINERS data base

on top of commit 136057256686de39cc3a07c2e39ef6bc43003ff6

 Linux 5.16-rc2

to receive device properties framework updates for 5.17-rc1.

These update the handling of software nodes and graph properties,
and the MAINTAINERS entry for the former.

Specifics:

 - Remove device_add_properties() which does not work correctly if
   software nodes holding additional device properties are shared
   or reused (Heikki Krogerus).

 - Fix nargs_prop property handling for software nodes (Clément Léger).

 - Update documentation of ACPI device properties (Sakari Ailus).

 - Update the handling of graph properties in the generic framework
   to match the DT case (Sakari Ailus).

 - Update software nodes entry in MAINTAINERS (Andy Shevchenko).

Thanks!


---------------

Andy Shevchenko (1):
      software node: Update MAINTAINERS data base

Clément Léger (1):
      software node: fix wrong node passed to find nargs_prop

Heikki Krogerus (3):
      PCI: Convert to device_create_managed_software_node()
      driver core: Don't call device_remove_properties() from device_del()
      device property: Remove device_add_properties() API

Sakari Ailus (7):
      device property: Fix fwnode_graph_devcon_match() fwnode leak
      device property: Fix documentation for FWNODE_GRAPH_DEVICE_DISABLED
      Documentation: ACPI: Fix data node reference documentation
      Documentation: ACPI: Update references
      device property: Implement fwnode_graph_get_endpoint_count()
      device property: Use fwnode_graph_for_each_endpoint() macro
      device property: Drop fwnode_graph_get_remote_node()

---------------

 .../acpi/dsd/data-node-references.rst              |  28 +++--
 Documentation/firmware-guide/acpi/dsd/graph.rst    |  40 +++---
 Documentation/firmware-guide/acpi/dsd/leds.rst     |  40 +++---
 Documentation/firmware-guide/acpi/dsd/phy.rst      |  28 +++--
 MAINTAINERS                                        |   7 +-
 drivers/base/core.c                                |   1 -
 drivers/base/property.c                            | 137 ++++++---------------
 drivers/base/swnode.c                              |   2 +-
 drivers/pci/quirks.c                               |   2 +-
 drivers/staging/media/tegra-video/vi.c             |  12 +-
 include/linux/property.h                           |  12 +-
 11 files changed, 127 insertions(+), 182 deletions(-)
