Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CFA6484271
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 14:28:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233563AbiADN2p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 08:28:45 -0500
Received: from mail-0201.mail-europe.com ([51.77.79.158]:52436 "EHLO
        mail-0201.mail-europe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232341AbiADN2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 08:28:43 -0500
Date:   Tue, 04 Jan 2022 13:28:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail2; t=1641302919;
        bh=tnZ90/s79QoQ7OL73E5GwpAoLzHFaRx7e6cmfgcThhw=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:
         References:From:To:Cc;
        b=IfcoIhont0bWHIUoc+w5y/eqqJCd/4ZKbeD2BkkdJxS8Ev46UF2CSNor7Xwrme7go
         VHOcWK3i3Ucm5bGf9V/G6g/bDU1qobxx8ZIBRAHucFx9mj6On7+JhON5BPCq43xSCL
         a8fU+VjFzjJ157KMHSTUJj3URanouR8YwZ477g93gF88jMuh6Q2dJkAJs/9vfTEbze
         XL80KBg5CP+FHDZuCpnyYYYpgVPY1ZiyDaDAHw0FPK2FDhYxtKeVgi/jcqHRZsQp8w
         Su8DKRAg//xz55x6pu4HC8GEVGREVogCG92u+D1xW3bLpdG40RIx+ksWHmcKSIPbT4
         CaVS51DEpOeYw==
To:     Rob Herring <robh+dt@kernel.org>, Ilia Lin <ilia.lin@kernel.org>,
        Niklas Cassel <nks@flawful.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org
From:   Yassine Oudjana <y.oudjana@protonmail.com>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        linux-kernel@vger.kernel.org
Reply-To: Yassine Oudjana <y.oudjana@protonmail.com>
Subject: [PATCH 3/7] dt-bindings: opp: qcom-opp: Convert to DT schema
Message-ID: <20220104132618.391799-4-y.oudjana@protonmail.com>
In-Reply-To: <20220104132618.391799-1-y.oudjana@protonmail.com>
References: <20220104132618.391799-1-y.oudjana@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert qcom-opp.txt to DT schema format.

Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
---
 .../bindings/opp/opp-v2-qcom-level.yaml       | 60 +++++++++++++++++++
 .../devicetree/bindings/opp/qcom-opp.txt      | 19 ------
 2 files changed, 60 insertions(+), 19 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/opp/opp-v2-qcom-level=
.yaml
 delete mode 100644 Documentation/devicetree/bindings/opp/qcom-opp.txt

diff --git a/Documentation/devicetree/bindings/opp/opp-v2-qcom-level.yaml b=
/Documentation/devicetree/bindings/opp/opp-v2-qcom-level.yaml
new file mode 100644
index 000000000000..14a7a689ad6d
--- /dev/null
+++ b/Documentation/devicetree/bindings/opp/opp-v2-qcom-level.yaml
@@ -0,0 +1,60 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/opp/opp-v2-qcom-level.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm OPP bindings to describe OPP nodes.
+
+maintainers:
+  - Niklas Cassel <nks@flawful.org>
+
+allOf:
+  - $ref: opp-v2-base.yaml#
+
+properties:
+  compatible:
+    const: operating-points-v2-qcom-level
+
+patternProperties:
+  '^opp-?[0-9]+$':
+    type: object
+
+    properties:
+      opp-level: true
+
+      qcom,opp-fuse-level:
+        description: |
+          A positive value representing the fuse corner/level associated w=
ith
+          this OPP node. Sometimes several corners/levels shares a certain=
 fuse
+          corner/level. A fuse corner/level contains e.g. ref uV, min uV,
+          and max uV.
+        $ref: /schemas/types.yaml#/definitions/uint32
+
+    required:
+      - opp-level
+      - qcom,opp-fuse-level
+
+required:
+  - compatible
+
+additionalProperties: false
+
+examples:
+  - |
+    cpr_opp_table: opp-table-cpr {
+        compatible =3D "operating-points-v2-qcom-level";
+
+        cpr_opp1: opp1 {
+            opp-level =3D <1>;
+            qcom,opp-fuse-level =3D <1>;
+        };
+        cpr_opp2: opp2 {
+            opp-level =3D <2>;
+            qcom,opp-fuse-level =3D <2>;
+        };
+        cpr_opp3: opp3 {
+            opp-level =3D <3>;
+            qcom,opp-fuse-level =3D <3>;
+        };
+    };
diff --git a/Documentation/devicetree/bindings/opp/qcom-opp.txt b/Documenta=
tion/devicetree/bindings/opp/qcom-opp.txt
deleted file mode 100644
index 41d3e4ff2dc3..000000000000
--- a/Documentation/devicetree/bindings/opp/qcom-opp.txt
+++ /dev/null
@@ -1,19 +0,0 @@
-Qualcomm OPP bindings to describe OPP nodes
-
-The bindings are based on top of the operating-points-v2 bindings
-described in Documentation/devicetree/bindings/opp/opp-v2-base.yaml
-Additional properties are described below.
-
-* OPP Table Node
-
-Required properties:
-- compatible: Allow OPPs to express their compatibility. It should be:
-  "operating-points-v2-qcom-level"
-
-* OPP Node
-
-Required properties:
-- qcom,opp-fuse-level: A positive value representing the fuse corner/level
-  associated with this OPP node. Sometimes several corners/levels shares
-  a certain fuse corner/level. A fuse corner/level contains e.g. ref uV,
-  min uV, and max uV.
--=20
2.34.1


