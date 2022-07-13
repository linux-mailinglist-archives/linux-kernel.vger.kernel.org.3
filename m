Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55668573ABE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 18:01:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237097AbiGMQBe convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 13 Jul 2022 12:01:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236663AbiGMQB2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 12:01:28 -0400
Received: from relay4.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE6CD2C649
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 09:01:26 -0700 (PDT)
Received: from omf18.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay06.hostedemail.com (Postfix) with ESMTP id CFEA934F0C;
        Wed, 13 Jul 2022 16:01:22 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf18.hostedemail.com (Postfix) with ESMTPA id 16A9E34;
        Wed, 13 Jul 2022 16:01:16 +0000 (UTC)
Message-ID: <75404573094d1c46172fcd51dad6a4e564da1542.camel@perches.com>
Subject: Re: [PATCH] soundwire: qcom: Update error prints to debug prints
From:   Joe Perches <joe@perches.com>
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        vkoul@kernel.org, agross@kernel.org, bjorn.andersson@linaro.org,
        lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        quic_plai@quicinc.com, bgoswami@quicinc.com, perex@perex.cz,
        tiwai@suse.com, srinivas.kandagatla@linaro.org,
        quic_rohkumar@quicinc.com, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, swboyd@chromium.org,
        judyhsiao@chromium.org
Date:   Wed, 13 Jul 2022 09:01:16 -0700
In-Reply-To: <8cde58d2-3b10-b88b-2d10-88e76fbcac06@quicinc.com>
References: <1657714921-28072-1-git-send-email-quic_srivasam@quicinc.com>
         <75e9b775-3bbe-0b34-2bd6-b4ac74620672@linux.intel.com>
         <8cde58d2-3b10-b88b-2d10-88e76fbcac06@quicinc.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.1-0ubuntu1 
MIME-Version: 1.0
X-Rspamd-Server: rspamout06
X-Rspamd-Queue-Id: 16A9E34
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Stat-Signature: oamptbghkx51eutk1cq8n1rajg7frenc
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/ELQpropLow+VPSUREm5LEbTNOk8SYDOE=
X-HE-Tag: 1657728076-660807
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-07-13 at 20:22 +0530, Srinivasa Rao Mandadapu wrote:
> On 7/13/2022 7:53 PM, Pierre-Louis Bossart wrote:
> Thanks for your time Pierre-Louis!!!
> > 
> > On 7/13/22 07:22, Srinivasa Rao Mandadapu wrote:
> > > Upadte error prints to debug prints to avoid redundant logging in kernel
> > update
[]
> > > diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
[]
> > > @@ -573,11 +573,10 @@ static irqreturn_t qcom_swrm_irq_handler(int irq, void *dev_id)
> > >   				break;
> > >   			case SWRM_INTERRUPT_STATUS_NEW_SLAVE_ATTACHED:
> > >   			case SWRM_INTERRUPT_STATUS_CHANGE_ENUM_SLAVE_STATUS:
> > > -				dev_err_ratelimited(swrm->dev, "%s: SWR new slave attached\n",
> > > -					__func__);
> > > +				dev_dbg(swrm->dev, "%s: SWR new slave attached\n", __func__);

Could also drop the "%s: ", __func__ as it's already a unique message
and dynamic debug could add it back if really desired.

