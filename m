Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F9D556A6E0
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 17:28:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235902AbiGGP2y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 11:28:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231897AbiGGP2w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 11:28:52 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F244D17042
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 08:28:49 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id l81so23792823oif.9
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jul 2022 08:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=i5AE8o89mnGPcosRIRhrsVkWToKcuuB5h1wqp957T/0=;
        b=vZnql2KWKVCzhxPaXfTaqmisk8cjDnIVfdnb/TKBxne5cNdOvIpRvrtRcPltQs3kSE
         3nDfTq3nIRJSDr+cVXgHI4HYtQhiFyr+9qSO/N56ojyRY9YqXxzQmQ6G8yCxnurG/mWe
         giCosSuT7OCE/WQr9iGKvroqZ4mlgzzhMleGzfhZrbs3dgqKRN/VHzhNK0k2as4XSR76
         AnO9oN7NYt1p7eSJYxNxfPXZWpERt7voJJfkVsILDXZLJLW4Lx3KX7UqMh9LmkC2VuGH
         ZWFtgqXmst83bgG6bugZR6FqiDPZCcnk1faNC0Eo5Xkq8yGZP/HTe5Fy9lRNEizKoW0Z
         AJRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=i5AE8o89mnGPcosRIRhrsVkWToKcuuB5h1wqp957T/0=;
        b=3YqFHeqDKVcQbOrgg/0Wfhq6QCe39Iw2rvQmdToSNb3dk4TTqMEj3zb6zk+AEKNSeF
         Sb0if9Jevt7I0l1VQSFm5Ua9fUnpwGVmmltyCqG90P56w6J3m/oPj0WHU2v/ypa+FZWG
         mouxomO5V+zwkYK4Pa3bd6jmKqtQLSpwMZ+9tZJuNKV/TRPG1v57vcw3oY3lZxmk7Plx
         XumOomxchIlSyCMVkrndPxb010A259gUuJSTOFjD7z0Rg7plRMmmnitcKbxpkklFz8Nc
         QA5R7uezHkRY7PA6CouniKYTnYlEJgrnNNvuFuw+w6sDOQaA1S1vxNfFGEIvnJSnuvij
         oYVg==
X-Gm-Message-State: AJIora+sWWXpAWm95FxFpk1Q4/K0CffinIdHzVTczj7TlSkddub6Q+C/
        rQmV9+F58AE9na8Ee/vfg0u6vg==
X-Google-Smtp-Source: AGRyM1v0p45heGfLNOXJAW3K1vcnOUrkm24+ImaKNgVgiVn0QiJINRs1nHObgKf7rHCAOqQAnMw9Ew==
X-Received: by 2002:a05:6808:1204:b0:325:7ce2:77f6 with SMTP id a4-20020a056808120400b003257ce277f6mr2913189oil.165.1657207727810;
        Thu, 07 Jul 2022 08:28:47 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id z18-20020a056808065200b0032ba1b363d2sm15593991oih.55.2022.07.07.08.28.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 08:28:47 -0700 (PDT)
Date:   Thu, 7 Jul 2022 10:28:45 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Cc:     agross@kernel.org, robh+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_rohkumar@quicinc.com,
        srinivas.kandagatla@linaro.org, dianders@chromium.org,
        swboyd@chromium.org, judyhsiao@chromium.org
Subject: Re: [PATCH v14 00/12] Add soundcard support for sc7280 based
 platforms.
Message-ID: <Ysb7rZ4tIpN9fm8w@builder.lan>
References: <1657200184-29565-1-git-send-email-quic_srivasam@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1657200184-29565-1-git-send-email-quic_srivasam@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 07 Jul 08:22 CDT 2022, Srinivasa Rao Mandadapu wrote:

> This patch set is to add bolero digital macros, WCD and maxim codecs nodes
> for audio on sc7280 based platforms.
> 
> This patch set depends on:
>     [LPASS DTS: wcd related pinmux reorg]
>     -- https://patchwork.kernel.org/project/linux-arm-msm/list/?series=657389
>     [Clock DTS: reset control changes]
>     -- https://patchwork.kernel.org/project/linux-arm-msm/list/?series=638002
>     [Clock: External MCLK and reset control driver changes]
>     -- https://patchwork.kernel.org/project/linux-arm-msm/list/?series=650267

As far as I understand I can't apply this series until Taniya's clock
patches has been picked up?

>     [Clock DTS: lpasscc node disable and lpasscore node name changes]
>     -- https://patchwork.kernel.org/project/linux-arm-msm/list/?series=657325

You're the author of these 3 other patch sets, so why are you asking me
to stitch them together, instead of just sending me one series that I
can easily apply.

If you want your patches merged, make it easy for the maintainer to
merge them!

Regards,
Bjorn

> 
> Changes Since V13:
>     -- Move digital codecs enabling to separate wcd specific dtsi file in CRD 3.0+ patches.
>     -- Remove redundant output high setting in wcd reset node.
>     -- Revert external mclk name.
>     -- Update dependency list.
>     -- Rebase as per latest kernel repository.
> Changes Since V12:
>     -- Update 'lpasscore' clock node name to lpass_core to match latest clock patches.
>     -- Update external mclk0 name and it's source node.
>     -- Move sound node to separate wcd specific dtsi file.
>     -- Move CRD specific lpass_cpu node Enabling to separate wcd specific dtsi file.
>     -- Update dependency list.
> Changes Since V11:
>     -- Remove output-low pinconf setting in wcd-reset-n-sleep node.
>     -- Update dependency list.
> Changes Since V10:
>     -- Modify digital macro codecs pin control labels.
>     -- Updated dependency list.
> Changes Since V9:
>     -- Move wcd codec and digital codec nodes to sc7280-qcard file.
>     -- Modify the reg property as per link number in sound node.
>     -- Fix the us-euro pin control usage in wcd codec node.
>     -- Move wcd pin control nodes to specific crd board files.
>     -- Sort max98360a codec node in alphabetical order.
>     -- Modify the commit messages.
> Changes Since V8:
>     -- Split patches as per sc7280 CRD revision 3, 4 and 5 boards.
>     -- Add corresponding dt nodes for herobrine crd boards.
>     -- Update dai-link node names as per dt-bindings in sound node.
>     -- Add reg property in sound node as per dt-bindings which was removed in previous series.
>     -- Fix typo errors.
>     -- Update wcd codec pin control properties in board specific files.
> Changes Since V7:
>     -- Remove redundant interrupt names in soundwire node.
>     -- Fix typo errors.
>     -- Remove redundant reg property in sound node.
>     -- Rebased on top of latest kernel tip.
> Changes Since V6:
>     -- Modify link-names and audio routing in a sound node.
>     -- Move amp_en pin control node to appropriate consumer patch.
>     -- Split patches as per digital macro codecs and board specific codecs and sort it.
>     -- Modify label and node names to lpass specific.
> Changes Since V5:
>     -- Move soc specific bolero digital codec nodes to soc specific file.
>     -- Bring wcd938x codec reset pin control and US/EURO HS selection nodes from other series.
>     -- Change node name and remove redundant status property in sound node.
> Changes Since V4:
>     -- Update nodes in sorting order.
>     -- Update DTS node names as per dt-bindings.
>     -- Update Node properties in proper order.
>     -- Update missing pinctrl properties like US/EURO HS selection, wcd reset control.
>     -- Remove redundant labels.
>     -- Remove unused size cells and address cells in tx macro node.
>     -- Keep all same nodes at one place, which are defined in same file.
>     -- Add max98360a codec node to herobrine board specific targets.
> Changes Since V3:
>     -- Move digital codec macro nodes to board specific dtsi file.
>     -- Update pin controls in lpass cpu node.
>     -- Update dependency patch list.
>     -- Create patches on latest kernel.
> Changes Since V2:
>     -- Add power domains to digital codec macro nodes.
>     -- Change clock node usage in lpass cpu node.
>     -- Add codec mem clock to lpass cpu node.
>     -- Modify the node names to be generic.
>     -- Move sound and codec nodes to root node.
>     -- sort dai links as per reg.
>     -- Fix typo errors.
> Changes Since V1:
>     -- Update the commit message of cpu node patch.
>     -- Add gpio control property to support Euro headset in wcd938x node.
>     -- Fix clock properties in lpass cpu and digital codec macro node.
> 
> Srinivasa Rao Mandadapu (12):
>   arm64: dts: qcom: sc7280: Add nodes for soundwire and va tx rx digital
>     macro codecs
>   arm64: dts: qcom: sc7280: Enable digital codecs and soundwire for CRD
>     1.0/2.0 and IDP boards
>   arm64: dts: qcom: sc7280: Enable digital codecs and soundwire for CRD
>     3.0/3.1
>   arm64: dts: qcom: sc7280: Add wcd9385 codec node for CRD 1.0/2.0 and
>     IDP boards
>   arm64: dts: qcom: sc7280: Add wcd9385 codec node for CRD 3.0/3.1
>   arm64: dts: qcom: sc7280: Add max98360a codec for CRD 1.0/2.0 and IDP
>     boards
>   arm64: dts: qcom: sc7280: herobrine: Add max98360a codec node
>   arm64: dts: qcom: sc7280: Add lpass cpu node
>   arm64: dts: qcom: sc7280: Enable lpass cpu node for CRD 1.0/2.0 and
>     IDP boards.
>   arm64: dts: qcom: sc7280: Enable lpass cpu node for CRD 3.0/3.1
>   arm64: dts: qcom: sc7280: Add sound node for CRD 1.0/2.0 and IDP
>     boards
>   arm64: dts: qcom: sc7280: Add sound node for CRD 3.0/3.1
> 
>  arch/arm64/boot/dts/qcom/sc7280-crd-r3.dts         |  37 ++++
>  .../dts/qcom/sc7280-herobrine-audio-wcd9385.dtsi   | 155 +++++++++++++++
>  arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi     |   8 +
>  arch/arm64/boot/dts/qcom/sc7280-idp.dtsi           | 216 +++++++++++++++++++++
>  arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi         |  73 +++++++
>  arch/arm64/boot/dts/qcom/sc7280.dtsi               | 190 ++++++++++++++++++
>  6 files changed, 679 insertions(+)
> 
> -- 
> 2.7.4
> 
