Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 160AA52F0F6
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 18:46:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351794AbiETQp4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 12:45:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351801AbiETQpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 12:45:54 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D73BEDF7D
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 09:45:52 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id s23-20020a9d7597000000b0060ae566f9a1so3227007otk.1
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 09:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PlINhk7EGOTlZ4qmuhnHPweUlYCEUBqXJztmztIUBZw=;
        b=ddxIeI9sJFsnX/Vz2xOvpXlnwwYauLTZBX+ayq0TJDXeIOXa+k3eEu6rXI9WC2Gv1K
         vfrc3f3+84jZlyAtt6x3DdoU8Wj0jVoR6d0z/O/wRvYH/HQcfPrcyMuv6J3l6cKx54af
         ZZgYW8qlS1qxp7hGHUcsLAg4kXT0CFXTwjVglvPyuxpW9+E92/byqnEm3s8XSKwgG1f7
         usttOrn8JWmRCiBoD7Kwl8Jh1qoMskvkmrg7JPUJc+9E4dbobBSapJMrXxiyUL8dZN89
         RabifZoCHLOgnin5RI3sXSVav/MwefPj7FPPhX7YJdbjfFQoAeqx/QC6gDS9RILsYlMj
         GeDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PlINhk7EGOTlZ4qmuhnHPweUlYCEUBqXJztmztIUBZw=;
        b=0jjPx0uzZpdaWBGDemKW4XR2/BKpFFT9DOC+qr0jopZ2OtYVMCyTl0tWOXma/wvdFC
         xVCehjv0WcsiO63jKStN3z527ohxXcyqWRyQHNl/QN/c8n4yqcLEOH09Q7fcNXBDIe8c
         y42vHvxvGzMu628u5wk3kVPoibpu7VpSRKmieoUGq4W6Lb9Goa/UcZ03hyp9NuSSaOJE
         1bcr18bPdyWwMq3Tqs3H6EY0/gE2jNtzgVLsa26ihbv6q0CJigUEIS66qGMTwHzAGlVv
         J3zdZk6yHATObzuVaIUjUVyLAABFBurTsfvpCq5qXOugtR3VHYzhSR7bulIC4DJYVk9e
         Ik0w==
X-Gm-Message-State: AOAM5335hjyQieeZunRFrwpJHUXd9zg9DuXhtNYOh0m23GF9Ys8bETbD
        yMjLhF6Y4eFmjPRgQZTA+aZz/g==
X-Google-Smtp-Source: ABdhPJyf+/2DFR6FGO/xyM3r5LsVtiMZ7hfwh5hXIy/FNY7AX0/rChz110sR3Cprn6btbbDTdt436w==
X-Received: by 2002:a05:6830:d7:b0:606:ac62:ed22 with SMTP id x23-20020a05683000d700b00606ac62ed22mr4462496oto.379.1653065152083;
        Fri, 20 May 2022 09:45:52 -0700 (PDT)
Received: from ripper.. (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id s184-20020acac2c1000000b0032aed1d25efsm1205014oif.7.2022.05.20.09.45.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 09:45:51 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kyle Tso <kyletso@google.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, dianders@chromium.org,
        swboyd@chromium.org, quic_subbaram@quicinc.com,
        Kuogee Hsieh <quic_khsieh@quicinc.com>
Subject: [PATCH/RFC] dt-bindings: connector: Add port for OOB notifications
Date:   Fri, 20 May 2022 09:48:10 -0700
Message-Id: <20220520164810.141400-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In USB Type-C altmode hot plug interrupts are transferred using sideband
channels. Introduce an additional port in the usb-c-connector to allow
referencing the recipient of these notifications.

A typical node to be referred is a DisplayPort controller.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

I have a USB Type-C port manager with two usb-c-connector child nodes and I
have two display-port controller nodes. I need a way to link each port with
it's related displayport controller, for the purpose of passing hot-plug events
from USB PD to the dp driver.

The displayport binding [1] specifies port@1 as "Output endpoint of the
controller" and in case of being connected to an eDP panel or a dp-controller
this links the node with whatever the output is.

It has been suggested by some to describe the link from the usb-c-connector add
a displayport = <&phandle> to each usb-c-connector node, but the proposed
solution here would make the usb-c-connector case follow the same scheme as
these other cases.

Also, using the graph would allow an implementation of either the tcpm just
notifying the referenced displayport-controller, or following the dp-controller
implementation in Linux implement a drm_bridge and use the reference in the
other direction.

To clarify the end result would look something like:

tcpm {
	connector@0 {
		compatible = "usb-c-connector";
		reg = <0>;

		ports {
			port@0 {
				reg = <0>;
				endpoint {
					remote-endpoint = <&usb0_hs_mux>;
				};
			};

			port@1 {
				reg = <1>;
				endpoint {
					remote-endpoint = <&usb0_ss_mux>;
				};
			};

			port@2 {
				reg = <2>;
				endpoint {
					remote-endpoint = <&usb0_sbu_switch>;
				};
			};

			connector0_dp0: port@3 {
				reg = <1>;
				endpoint {
					remote-endpoint = <&dp0_connector0>;
				};
			};
		};
	};

	connector@1 {
		compatible = "usb-c-connector";
		reg = <1>;

		ports {
			port@0 {
				reg = <0>;
				endpoint {
					remote-endpoint = <&usb1_hs_mux>;
				};
			};

			port@1 {
				reg = <1>;
				endpoint {
					remote-endpoint = <&usb1_ss_mux>;
				};
			};

			port@2 {
				reg = <2>;
				endpoint {
					remote-endpoint = <&usb1_sbu_switch>;
				};
			};

			connector1_dp1: port@3 {
				reg = <1>;
				endpoint {
					remote-endpoint = <&dp1_connector1>;
				};
			};
		};
	};
}

displayport-controller@0 {
	reg = <0x0>;
	ports {
		port@1 {
			reg = <1>;
			dp0_connector0: endpoint {
				remote-endpoint = <&connector0_dp0>;
			};
		};
	};
};

displayport-controller@1 {
	reg = <0x1>;
	ports {
		port@1 {
			reg = <1>;
			dp1_connector1: endpoint {
				remote-endpoint = <&connector1_dp1>;
			};
		};
	};
};

[1] https://www.kernel.org/doc/Documentation/devicetree/bindings/display/msm/dp-controller.yaml

 .../devicetree/bindings/connector/usb-connector.yaml        | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/connector/usb-connector.yaml b/Documentation/devicetree/bindings/connector/usb-connector.yaml
index 0420fa563532..99d4aeb233e5 100644
--- a/Documentation/devicetree/bindings/connector/usb-connector.yaml
+++ b/Documentation/devicetree/bindings/connector/usb-connector.yaml
@@ -189,6 +189,12 @@ properties:
         description: Sideband Use (SBU), present in USB-C. This describes the
           alternate mode connection of which SBU is a part.
 
+      port@3:
+        $ref: /schemas/graph.yaml#/properties/port
+        description: Out-of-band notifications. This describes the logical
+          connection to e.g. a DisplayPort controller that should be notified
+          about hot plug events.
+
     required:
       - port@0
 
-- 
2.35.1

