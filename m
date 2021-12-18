Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03899479C28
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Dec 2021 19:49:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233891AbhLRStE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Dec 2021 13:49:04 -0500
Received: from ixit.cz ([94.230.151.217]:42040 "EHLO ixit.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233871AbhLRStD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Dec 2021 13:49:03 -0500
Received: from [192.168.1.138] (ip-89-176-96-70.net.upcbroadband.cz [89.176.96.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ixit.cz (Postfix) with ESMTPSA id A745F2243C;
        Sat, 18 Dec 2021 19:49:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
        t=1639853341;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fi1/ahYzUfgNf7k8qooILk/MXB0xNwBc1FbfH2vZ9HI=;
        b=sONuUUkIxe5DdfeWO3FwNbAfaV6BI8qBPTJ92THZOI4tHXaMuNa2RQoFXCY65cdbVWeIAO
        jXYBouBQZth9VFRnW3gE4XS2En7T/joc5LNGHvE+rbdEVgMGXHmicURv9xJ06km6HP4oZw
        lyettBwpx7DzJpZLqrTGse/G/SxOEkI=
Date:   Sat, 18 Dec 2021 19:48:54 +0100
From:   David Heidelberg <david@ixit.cz>
Subject: Re: [PATCH] dt-binding: soc: qcom: convert Qualcomm Command DB
 documentation to yaml
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     ~okias/devicetree@lists.sr.ht, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <IXQB4R.TDKX07UI05SQ3@ixit.cz>
In-Reply-To: <20211218184617.19923-1-david@ixit.cz>
References: <20211218184617.19923-1-david@ixit.cz>
X-Mailer: geary/40.0
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since Mahesh Sivasubramanian <msivasub@codeaurora.org> email doesn't 
exist anymore (returned with 550 User doesn't exist.), who should I 
assign as maintainer for this document?
Davi

On Sat, Dec 18 2021 at 19:46:16 +0100, David Heidelberg <david@ixit.cz> 
wrote:
> Convert Qualcomm Command DB documentation into yaml format.
> 
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
>  .../bindings/reserved-memory/qcom,cmd-db.txt  | 37 ---------------
>  .../bindings/reserved-memory/qcom,cmd-db.yaml | 46 
> +++++++++++++++++++
>  2 files changed, 46 insertions(+), 37 deletions(-)
>  delete mode 100644 
> Documentation/devicetree/bindings/reserved-memory/qcom,cmd-db.txt
>  create mode 100644 
> Documentation/devicetree/bindings/reserved-memory/qcom,cmd-db.yaml
> 
> diff --git 
> a/Documentation/devicetree/bindings/reserved-memory/qcom,cmd-db.txt 
> b/Documentation/devicetree/bindings/reserved-memory/qcom,cmd-db.txt
> deleted file mode 100644
> index 68395530c0a5..000000000000
> --- 
> a/Documentation/devicetree/bindings/reserved-memory/qcom,cmd-db.txt
> +++ /dev/null
> @@ -1,37 +0,0 @@
> -Command DB
> ----------
> -
> -Command DB is a database that provides a mapping between resource 
> key and the
> -resource address for a system resource managed by a remote 
> processor. The data
> -is stored in a shared memory region and is loaded by the remote 
> processor.
> -
> -Some of the Qualcomm Technologies Inc SoC's have hardware 
> accelerators for
> -controlling shared resources. Depending on the board configuration 
> the shared
> -resource properties may change. These properties are dynamically 
> probed by the
> -remote processor and made available in the shared memory.
> -
> -The bindings for Command DB is specified in the reserved-memory 
> section in
> -devicetree. The devicetree representation of the command DB driver 
> should be:
> -
> -Properties:
> -- compatible:
> -	Usage: required
> -	Value type: <string>
> -	Definition: Should be "qcom,cmd-db"
> -
> -- reg:
> -	Usage: required
> -	Value type: <prop encoded array>
> -	Definition: The register address that points to the actual location 
> of
> -		    the Command DB in memory.
> -
> -Example:
> -
> -	reserved-memory {
> -		[...]
> -		reserved-memory@85fe0000 {
> -			reg = <0x0 0x85fe0000 0x0 0x20000>;
> -			compatible = "qcom,cmd-db";
> -			no-map;
> -		};
> -	};
> diff --git 
> a/Documentation/devicetree/bindings/reserved-memory/qcom,cmd-db.yaml 
> b/Documentation/devicetree/bindings/reserved-memory/qcom,cmd-db.yaml
> new file mode 100644
> index 000000000000..fa5cd6a77634
> --- /dev/null
> +++ 
> b/Documentation/devicetree/bindings/reserved-memory/qcom,cmd-db.yaml
> @@ -0,0 +1,46 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: 
> "http://devicetree.org/schemas/reserved-memory/qcom,cmd-db.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: Qualcomm Command DB
> +
> +description: |
> +  Command DB is a database that provides a mapping between resource 
> key and the
> +  resource address for a system resource managed by a remote 
> processor. The data
> +  is stored in a shared memory region and is loaded by the remote 
> processor.
> +
> +  Some of the Qualcomm Technologies Inc SoC's have hardware 
> accelerators for
> +  controlling shared resources. Depending on the board configuration 
> the shared
> +  resource properties may change. These properties are dynamically 
> probed by the
> +  remote processor and made available in the shared memory.
> +
> +maintainers:
> +  - Mahesh Sivasubramanian <msivasub@codeaurora.org>
> +
> +allOf:
> +  - $ref: "reserved-memory.yaml"
> +
> +properties:
> +  compatible:
> +    const: qcom,cmd-db
> +
> +required:
> +  - reg
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    reserved-memory {
> +        #address-cells = <1>;
> +        #size-cells = <1>;
> +        ranges;
> +
> +        reserved-memory@85fe0000 {
> +            reg = <0x85fe0000 0x20000>;
> +            compatible = "qcom,cmd-db";
> +            no-map;
> +        };
> +    };
> --
> 2.34.1
> 


