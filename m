Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3A2047C0B0
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 14:19:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238152AbhLUNTz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 08:19:55 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:35388 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235288AbhLUNTy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 08:19:54 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 46381615A9;
        Tue, 21 Dec 2021 13:19:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC388C36AEB;
        Tue, 21 Dec 2021 13:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640092793;
        bh=si/OavSeoSBngnHkOx9IF/AzCke6m5sxieeo9KjaURk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=uZ71KPnoSH83KUCEECdp4QPheL7hVeoxfDy9CMv0zsh4yCtspkyWbZJr8Ztd0iwzT
         hGuwhYSeaZywsHHJRJVqPEOJEURDXs0muDlj8gzPl6iOcuaBM511ANgiQFEOKXYU92
         gXRkES/eDhTVq65TiF+1yBbXM3Qsj8MqYJn0cLcpZiPaLUxpnRKGt5on4RIV6PSXYi
         ljy47vt+fnT1ecC4/NNFN0X25s6A5jvfROnG+HzRiiL4Z5BAyo7LHGUazY5i1yR88m
         dvUiiJfW9G8hRfzbWnBFlNus4mSuekb/kpO7MiyPLzfZOJDr53x82ei4xQSwEuKFwG
         v0Iit8DYwEvhA==
Received: by mail-ed1-f47.google.com with SMTP id bm14so39080324edb.5;
        Tue, 21 Dec 2021 05:19:53 -0800 (PST)
X-Gm-Message-State: AOAM531HwAlIEggbBFlg7YwBSWPix42vdBd936Tv12kXFGIRqacCzM4H
        VO7F6JcZsuL/9GE3l8/6UIxVmYMcBPRJggD3ZA==
X-Google-Smtp-Source: ABdhPJwd681NVmCNJDAiTucwZYvRsGIIdGam7p0YhgGV8RYkiF73p71kMIoy3Ftb7FJzPCF2FEevHXY25jCdG+Omg7g=
X-Received: by 2002:a17:907:3d94:: with SMTP id he20mr2645147ejc.14.1640092791861;
 Tue, 21 Dec 2021 05:19:51 -0800 (PST)
MIME-Version: 1.0
References: <20211218213556.42061-1-david@ixit.cz>
In-Reply-To: <20211218213556.42061-1-david@ixit.cz>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 21 Dec 2021 09:19:40 -0400
X-Gmail-Original-Message-ID: <CAL_JsqKRAnBOtk_tsXp6BqMOexB+Sz1dZOT6c_uzf-Vbuu_SRg@mail.gmail.com>
Message-ID: <CAL_JsqKRAnBOtk_tsXp6BqMOexB+Sz1dZOT6c_uzf-Vbuu_SRg@mail.gmail.com>
Subject: Re: [PATCH] RFC: dt-bindings: soc: qcom: convert GLINK binding to yaml
To:     David Heidelberg <david@ixit.cz>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        ~okias/devicetree@lists.sr.ht,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 18, 2021 at 5:36 PM David Heidelberg <david@ixit.cz> wrote:
>
> Convert Qualcomm GLINK binding to the yaml syntax.
>
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
>  .../bindings/soc/qcom/qcom,glink.txt          |  94 ----------------
>  .../bindings/soc/qcom/qcom,glink.yaml         | 106 ++++++++++++++++++
>  2 files changed, 106 insertions(+), 94 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,glink.txt
>  create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,glink.yaml
>
> diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,glink.txt b/Documentation/devicetree/bindings/soc/qcom/qcom,glink.txt
> deleted file mode 100644
> index 1214192847ac..000000000000
> --- a/Documentation/devicetree/bindings/soc/qcom/qcom,glink.txt
> +++ /dev/null
> @@ -1,94 +0,0 @@
> -Qualcomm GLINK edge binding
> -
> -This binding describes a Qualcomm GLINK edge, a fifo based mechanism for
> -communication between subsystem-pairs on various Qualcomm platforms. Two types
> -of edges can be described by the binding; the GLINK RPM edge and a SMEM based
> -edge.
> -
> -- compatible:
> -       Usage: required for glink-rpm
> -       Value type: <stringlist>
> -       Definition: must be "qcom,glink-rpm"
> -
> -- label:
> -       Usage: optional
> -       Value type: <string>
> -       Definition: should specify the subsystem name this edge corresponds to.
> -
> -- interrupts:
> -       Usage: required
> -       Value type: <prop-encoded-array>
> -       Definition: should specify the IRQ used by the remote processor to
> -                   signal this processor about communication related events
> -
> -- qcom,remote-pid:
> -       Usage: required for glink-smem
> -       Value type: <u32>
> -       Definition: specifies the identifier of the remote endpoint of this edge
> -
> -- qcom,rpm-msg-ram:
> -       Usage: required for glink-rpm
> -       Value type: <prop-encoded-array>
> -       Definition: handle to RPM message memory resource
> -
> -- mboxes:
> -       Usage: required
> -       Value type: <prop-encoded-array>
> -       Definition: reference to the "rpm_hlos" mailbox in APCS, as described
> -                   in mailbox/mailbox.txt
> -
> -= GLINK DEVICES
> -Each subnode of the GLINK node represent function tied to a virtual
> -communication channel. The name of the nodes are not important. The properties
> -of these nodes are defined by the individual bindings for the specific function
> -- but must contain the following property:
> -
> -- qcom,glink-channels:
> -       Usage: required
> -       Value type: <stringlist>
> -       Definition: a list of channels tied to this function, used for matching
> -                   the function to a set of virtual channels
> -
> -- qcom,intents:
> -       Usage: optional
> -       Value type: <prop-encoded-array>
> -       Definition: a list of size,amount pairs describing what intents should
> -                   be preallocated for this virtual channel. This can be used
> -                   to tweak the default intents available for the channel to
> -                   meet expectations of the remote.
> -
> -= EXAMPLE
> -The following example represents the GLINK RPM node on a MSM8996 device, with
> -the function for the "rpm_request" channel defined, which is used for
> -regulators and root clocks.
> -
> -       apcs_glb: mailbox@9820000 {
> -               compatible = "qcom,msm8996-apcs-hmss-global";
> -               reg = <0x9820000 0x1000>;
> -
> -               #mbox-cells = <1>;
> -       };
> -
> -       rpm_msg_ram: memory@68000 {
> -               compatible = "qcom,rpm-msg-ram";
> -               reg = <0x68000 0x6000>;
> -       };
> -
> -       rpm-glink {
> -               compatible = "qcom,glink-rpm";
> -
> -               interrupts = <GIC_SPI 168 IRQ_TYPE_EDGE_RISING>;
> -
> -               qcom,rpm-msg-ram = <&rpm_msg_ram>;
> -
> -               mboxes = <&apcs_glb 0>;
> -
> -               rpm-requests {
> -                       compatible = "qcom,rpm-msm8996";
> -                       qcom,glink-channels = "rpm_requests";
> -
> -                       qcom,intents = <0x400 5
> -                                       0x800 1>;
> -                       ...
> -               };
> -       };
> diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,glink.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,glink.yaml
> new file mode 100644
> index 000000000000..11a7c845ea0a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/qcom/qcom,glink.yaml
> @@ -0,0 +1,106 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/soc/qcom/qcom,glink.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: Qualcomm GLINK edge
> +
> +description: |
> +  Qualcomm GLINK edge, a fifo based mechanism for communication between
> +  subsystem-pairs on various Qualcomm platforms. Two types of edges can be
> +  described by the binding; the GLINK RPM edge and a SMEM based.
> +
> +maintainers:
> +  - Bjorn Andersson <bjorn.andersson@linaro.org>
> +
> +properties:
> +  $nodename:
> +    pattern: "^(rpm-)?glink(-edge)?$"
> +
> +  compatible:
> +    const: qcom,glink-rpm
> +
> +  label:
> +    $ref: /schemas/types.yaml#/definitions/string
> +    description: should specify the subsystem name this edge corresponds to
> +
> +  interrupts:
> +    description: >
> +      should specify the IRQ used by the remote processor to
> +      signal this processor about communication related events
> +    maxItems: 1
> +
> +  mboxes:
> +    description: >
> +      reference to the "rpm_hlos" mailbox in APCS, as described
> +      in mailbox/mailbox.txt
> +
> +  qcom,remote-pid:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: specifies the identifier of the remote endpoint of this edge
> +
> +  qcom,rpm-msg-ram:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: RPM message memory resource
> +
> +patternProperties:
> +  ".*":

This doesn't work because it will match everything including the above
properties. You can use additionalProperties or unevaluatedProperties
instead.

> +    type: object
> +    properties:
> +      qcom,glink-channels:
> +        $ref: /schemas/types.yaml#/definitions/string
> +        description: >
> +          a list of channels tied to this function, used for matching
> +          the function to a set of virtual channels
> +
> +      'qcom,intents':

Don't need quotes.

> +        $ref: /schemas/types.yaml#/definitions/uint32-array
> +        description: >
> +          a list of size, amount pairs describing what intents should
> +          be preallocated for this virtual channel. This can be used
> +          to tweak the default intents available for the channel to
> +          meet expectations of the remote
> +
> +    required:
> +      - qcom,glink-channels
> +
> +    additionalProperties: true

However, if the child nodes are the above properties plus other device
specific properties as this indicates, then you need to split this to
a separate schema file for those device specific schemas to reference.
Otherwise, unevaluatedProperties can't see all the properties for the
child node.

Rob
