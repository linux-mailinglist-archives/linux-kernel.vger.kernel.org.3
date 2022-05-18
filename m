Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9554852C42C
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 22:22:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242314AbiERUID (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 16:08:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242317AbiERUH6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 16:07:58 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71DFD23EB59
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 13:07:56 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id i25-20020a9d6259000000b00605df9afea7so2139620otk.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 13:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=WgtNrJrhv5bCTIhJBeU8a6bia5VueZCuqtt19PJobgc=;
        b=m/R7+4+FpGTf4xWdG6rKoNguLNzHDKCbXTDgmtDNIyZ1OTRLFxXKHZx73pWHn6rgsA
         16PsXlcCi2+zblZNp8bqn3Y0ZxkrKF7FVX4eZZBKbW+4blOn1GSPs5nF2XZIibnj9Kpi
         Bvdgr19bkM121NgCX0qn5u52ktfdCIy/Jarss=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=WgtNrJrhv5bCTIhJBeU8a6bia5VueZCuqtt19PJobgc=;
        b=EuqFqAYT56kdWXZo/gGOa/IiJ0Gbi2VkxdoIza0fvwLmI1OechWfrGiLpRjQyGAmO2
         HApiJUBIzMaeG1SQonJLyDqi5v1wqGQZysUm6NVpSCYlX1JmlR76TNwwR1ufCWq1iVPI
         k5bKdJD8uwX98/cCz8cPCvFKMFq85psIM80vVbfaheFbe2qBgx8FLANHI2IT+KL28qoE
         vj0xrN6wkkkD+RvW233c6qNwlHCa9L46lkPxnbyXHbSq7xgJCqC4HWnHB1JJqm/tllwR
         YdUtA8912SvnB/y9XoheDtFnfQGyUgPKy5X4tLk2LSuzwGQnBzdtyusSdixEe4Iv3Trr
         WdDw==
X-Gm-Message-State: AOAM530XJqU9Hx7QG9k3mu+bscNsCojbPrADhi0R2LbyKw7ShzH4EF4P
        HxhqHhAeLulLo4rZ9l7yaOVoFLojjnNJRlpy4LTTuw==
X-Google-Smtp-Source: ABdhPJyJ7ONb1oWdAUazJjnnAp03o8+2u/wSw0YPZbj8oBuS2WRzetKTsNkIKSn0J98vjcan1tYa4qs+574uLdYie8I=
X-Received: by 2002:a05:6830:13ce:b0:606:702b:87f0 with SMTP id
 e14-20020a05683013ce00b00606702b87f0mr561772otq.159.1652904475487; Wed, 18
 May 2022 13:07:55 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 18 May 2022 13:07:55 -0700
MIME-Version: 1.0
In-Reply-To: <YoR+w7CSqN0aAE5b@google.com>
References: <20220516183452.942008-1-swboyd@chromium.org> <YoR+w7CSqN0aAE5b@google.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Wed, 18 May 2022 13:07:55 -0700
Message-ID: <CAE-0n50KE9bkqZvCOLtCGiq3g1jYhK7zpVcVFBzinaguNhNaPw@mail.gmail.com>
Subject: Re: [PATCH v5 0/2] Input: cros-ec-keyb: Better matrixless support
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        chrome-platform@lists.linux.dev,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        "Joseph S. Barrera III" <joebar@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Dmitry Torokhov (2022-05-17 22:06:11)
> Hi Stephen,
>
> On Mon, May 16, 2022 at 11:34:50AM -0700, Stephen Boyd wrote:
> > This is a followup to my previous patch[1] that skips keyboard registration
> > when the matrix properties aren't present. This adds a compatible string
> > for this scenario so we can ease existing DTBs over to the new design.
>
> As discussed offlist I massaged the binding and the driver code a bit
> and applied it to an immutable branch off v5.17:
>
>         git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git ib/5.17-cros-ec-keyb
>
> that you can share with DTS maintainer(s) to accelerate DTS conversions.
>
> I also dropped the original patch as it did not make it to Linus' tree
> yet.
>

Ok thanks. Doug noticed some problems with the dt binding. Here's a
follow up patch that you can squash in or apply on top.

---8<---
From: Stephen Boyd <swboyd@chromium.org>
Date: Wed, 18 May 2022 13:03:58 -0700
Subject: [PATCH] dt-bindings: google,cros-ec-keyb: Fixup bad compatible match

This uses anyOf which is wrong. Use oneOf and move the items under the
description. Also drop allOf for $ref.

Reported-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 .../bindings/input/google,cros-ec-keyb.yaml           | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/input/google,cros-ec-keyb.yaml
b/Documentation/devicetree/bindings/input/google,cros-ec-keyb.yaml
index e11cbf508723..c31a02149f37 100644
--- a/Documentation/devicetree/bindings/input/google,cros-ec-keyb.yaml
+++ b/Documentation/devicetree/bindings/input/google,cros-ec-keyb.yaml
@@ -20,13 +20,11 @@ description: |

 properties:
   compatible:
-    anyOf:
+    oneOf:
       - description: ChromeOS EC with only buttons/switches
-      - items:
-          - const: google,cros-ec-keyb-switches
+        const: google,cros-ec-keyb-switches
       - description: ChromeOS EC with keyboard and possibly buttons/switches
-      - items:
-          - const: google,cros-ec-keyb
+        const: google,cros-ec-keyb

   google,needs-ghost-filter:
     description:
@@ -58,8 +56,7 @@ if:
       contains:
         const: google,cros-ec-keyb
 then:
-  allOf:
-    - $ref: "/schemas/input/matrix-keymap.yaml#"
+  $ref: "/schemas/input/matrix-keymap.yaml#"
   required:
     - keypad,num-rows
     - keypad,num-columns
-- 
https://chromeos.dev
