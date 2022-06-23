Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08D96557911
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 13:51:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231552AbiFWLv5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 07:51:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbiFWLv4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 07:51:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9B174D247;
        Thu, 23 Jun 2022 04:51:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 87943B82260;
        Thu, 23 Jun 2022 11:51:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49D3CC341C7;
        Thu, 23 Jun 2022 11:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655985112;
        bh=YxjkbmtWiwKyXSfh9J1LCaGUej6BwFLLjiSLAdMtBEo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gpQy8Lwa6qn8PfIky19HgsNqZNmbA/uJArEGXy+A+f7hTIGSrW8MLkNPzgQUnc/Qd
         KuksUcv/lV3mrSYfXiPcpoouH+EXWFHqGG3j2XdKmT4bJyGcNbGf9z4FRdga8mD6yu
         n1T4ZbxaYKJ1SAPINP/e4o40VhII+9LptveuB7SZFQ5JXT/nFG7kgU+astQ3K4cpAQ
         cpLLoBeKI3rECMZDHTqXFpYzPGOCexhamO9J3QHhDlFf06h9diPNAxf71zD2usQ4PK
         TgCRjRPSCCBWIsh+CFftan8wWiz3dDLsDHowrL6BUGmFXRqeZOgsO70Mj9/cvtxMkA
         91QG7KxUS6Usg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1o4LNA-0007s6-5m; Thu, 23 Jun 2022 13:51:44 +0200
Date:   Thu, 23 Jun 2022 13:51:44 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Vinod Koul <vkoul@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] phy: qcom-qmp-pcie: drop obsolete pipe clock type
 check
Message-ID: <YrRT0O8xSq30U8mh@hovoldconsulting.com>
References: <20220623113314.29761-1-johan+linaro@kernel.org>
 <20220623113314.29761-2-johan+linaro@kernel.org>
 <CAA8EJpp0XAZ3V9XQ2QnbrVoiKrdD_mxoTpKuzC34hKVPQ7wT0g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA8EJpp0XAZ3V9XQ2QnbrVoiKrdD_mxoTpKuzC34hKVPQ7wT0g@mail.gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 23, 2022 at 02:44:28PM +0300, Dmitry Baryshkov wrote:
> On Thu, 23 Jun 2022 at 14:33, Johan Hovold <johan+linaro@kernel.org> wrote:
> >
> > Drop the obsolete pipe clock handling which was used to treat the pipe
> > clock as optional for types other than PCIe and USB and which is no
> > longer needed since splitting the PHY driver.
> >
> > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> > ---

> > diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> >         if (IS_ERR(qphy->pipe_clk)) {
> > -               if (cfg->type == PHY_TYPE_PCIE ||
> > -                   cfg->type == PHY_TYPE_USB3) {
> > -                       ret = PTR_ERR(qphy->pipe_clk);
> > -                       if (ret != -EPROBE_DEFER)
> > -                               dev_err(dev,
> > -                                       "failed to get lane%d pipe_clk, %d\n",
> > -                                       id, ret);
> > -                       return ret;
> > -               }
> > -               qphy->pipe_clk = NULL;
> > +               return dev_err_probe(dev, PTR_ERR(qphy->pipe_clk),
> > +                                    "failed to get lane%d pipe clock\n", id);
> >         }
> 
> Please remove the brackets around a single statement.

For readability reasons I prefer keeping brackets around statements
spanning multiple lines instead of relying on indentation. 

Johan
