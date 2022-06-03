Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D769B53C281
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 04:13:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237753AbiFCBTJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 21:19:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240941AbiFCBTG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 21:19:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA0073B021;
        Thu,  2 Jun 2022 18:19:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 616FD60ECB;
        Fri,  3 Jun 2022 01:19:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64A7EC385A5;
        Fri,  3 Jun 2022 01:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654219141;
        bh=AmufSJQlObY1ny4dNqKwvwz8g0x7sbqlUIpQGqjwk0A=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=F8crNy0OiIMsHFeKsubXKYfp3+kAGJTB3BRQifz6SpVIxq6awFw0FcV+fg0xRVGd9
         b/3oKApM1f0F8EYX15Ed3pyg7Ym5K3SSPZHBLHPeoaJ9DOMIfU7MoQwSLe0geQPD2t
         JlDgmlqdYxJJyG4168p4nJoUL/qTBBL7EcJOm+bc7szirG92/PwuEsAJ5Z3DXxqB8K
         3uR0eckhS7KX92jrdem7vfp/KtIssBg97v944c6lzp7fQRmbcD4rGTyMydCV3ARJfN
         AbPTONtJU80FzimwiO6uPPwaE1xYwBgcJPbwUfQMuCkJpr2l87aFrTBTT9P4Pyb58v
         O2ChUBSwQ228w==
Date:   Thu, 2 Jun 2022 18:19:00 -0700 (PDT)
From:   Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To:     Rob Herring <robh@kernel.org>
cc:     Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 0/1] dt-bindings: Add device-perms property
 description
In-Reply-To: <20220601193956.GA234900-robh@kernel.org>
Message-ID: <alpine.DEB.2.22.394.2206021818080.2783803@ubuntu-linux-20-04-desktop>
References: <cover.1651749565.git.oleksii_moisieiev@epam.com> <20220601193956.GA234900-robh@kernel.org>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Jun 2022, Rob Herring wrote:
> On Thu, May 05, 2022 at 11:23:50AM +0000, Oleksii Moisieiev wrote:
> > Introduce device-perms property which is intended to set the device
> > permissions for the System Management interfaces.
> > An example of this interface is SCMI (System Control and Management
> > Interface) which controls clocks/power-domains/resets etc from the
> > Firmware. This property sets the device_id to set the device permissions
> > for the Fimware using BASE_SET_DEVICE_PERMISSIONS message (see 4.2.2.10 of [0]).
> 
> Is that an exhaustive list of controls? Seems like there would be a 
> GET_DEVICE_PERMISSIONS.
> 
> > Device permissions management described in DEN 0056, Section 4.2.2.10 [0].
> > Given parameter should set the device_id, needed to set device
> > permissions in the Firmware.
> > This property is used by trusted Agent to set permissions for the devices,
> > passed-through to the non-trusted Agents. Trusted Agent will use device-perms to
> > set the Device permissions for the Firmware (See Section 4.2.2.10 [0]
> > for details).
> > Agents concept is described in Section 4.2.1 [0].
> 
> As I said on the call discussing this, this looks very similar to other 
> proposals wanting to control or check permissions on devices handled by 
> some provider. While the consumer of the binding is different in various 
> proposals, that doesn't really matter from a DT perspective. DT is just 
> describing some type of connection between nodes. So I'm looking for 
> collaboration here with folks that have made prior proposals. To put it 
> another way, for a new common binding like this, I want to see more than 
> one user. 

Do you have a pointer to another similar proposal or the name of someone
that might be interested and might be having a second use-case for this?
