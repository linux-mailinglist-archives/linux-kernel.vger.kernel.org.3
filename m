Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA2DB57A5F4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 20:00:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239821AbiGSSAd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 14:00:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239786AbiGSSAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 14:00:30 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7841327CE9;
        Tue, 19 Jul 2022 11:00:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 37B00B81CB9;
        Tue, 19 Jul 2022 18:00:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95A87C341C6;
        Tue, 19 Jul 2022 18:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658253626;
        bh=m9qWTMSf9/SCH6mrq7ILSn3CrVsp0AKrwaEDP+MK5OM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=X9NwKlYQanEvNa2qu8TkFSCqEBvOpEb/4Eq2AWY9Yk4iaWmK3pmCnJx3AlxAdTm5h
         hvOJS4nnmQ+nbamJR2V79tf708+xgwVd01/9EOngrZw1FSIgMmImXriCvUdwqfjbzN
         tK6OcIKfQzacakG2suHFuG90iGRFjgcqU+K3AAevBq2DlB1ubgJIA4I3j/9X4TE5uh
         FuRQtc8B9T2Ky7+r1AU8Hq7+hEageT9SqyTkIr6uTkmz3GiKMvxErcMAqijD50eOT/
         HFQowuMJW6wNLQHQfpsbhA27s7YnKF65FOXgLsTokACMZ1Ont6wn88gWiwAj1jrado
         agCfU0ansIFvw==
Date:   Tue, 19 Jul 2022 13:00:25 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Richard Zhu <hongxing.zhu@nxp.com>
Cc:     robh@kernel.org, l.stach@pengutronix.de, galak@kernel.crashing.org,
        shawnguo@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com, kernel@pengutronix.de
Subject: Re: [PATCH v2 1/3] dt-bindings: PCI: imx6: convert the imx pcie
 controller to dtschema
Message-ID: <20220719180025.GA1549128@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1630046580-19282-2-git-send-email-hongxing.zhu@nxp.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 27, 2021 at 02:42:58PM +0800, Richard Zhu wrote:
> Convert the fsl,imx6q-pcie.txt into a schema.
> - ranges property should be grouped by region, with no functional
>   changes.
> - only one propert is allowed in the compatible string, remove
>   "snps,dw-pcie".
> 
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> ---
>  .../bindings/pci/fsl,imx6q-pcie.txt           | 100 ---------
>  .../bindings/pci/fsl,imx6q-pcie.yaml          | 202 ++++++++++++++++++
>  MAINTAINERS                                   |   2 +-
>  3 files changed, 203 insertions(+), 101 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
>  create mode 100644 Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt

> -Optional properties:
> -- fsl,tx-deemph-gen1: Gen1 De-emphasis value. Default: 0
> -- fsl,tx-deemph-gen2-3p5db: Gen2 (3.5db) De-emphasis value. Default: 0

> diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml

> +  fsl,tx-deemph-gen1:
> +    description: Gen1 De-emphasis value (optional required).
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    default: 0
> +
> +  fsl,tx-deemph-gen2-3p5db:
> +    description: Gen2 (3.5db) De-emphasis value (optional required).
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    default: 0

What does "optional required" mean in all these properties?
"Optional" is the opposite of "required."
