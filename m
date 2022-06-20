Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25001551920
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 14:41:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242737AbiFTMk6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 08:40:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239184AbiFTMkz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 08:40:55 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5EEA7666;
        Mon, 20 Jun 2022 05:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1655728843;
        bh=KrVmb1xepHJ/Pzbfeisty0gKJhBZD1PGHrbEMv3MWpE=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=OFohnXD3oQUdewpBCd88CsFYJB0h2Uy9sbJsqevrEQy6ZrLMemiMrQNpPzkTeZ12x
         kuCbjN+GS68fpEiIRY/+R26pW2Yd11cEQqI6RRw2+ThMzL8V9wklJL952Etl93ZUpr
         wNalXpekHob7C2oHjBySGMxsmxE9W/4HsywR+8u8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.174.149]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MS3mz-1oEyo41FXv-00TUH3; Mon, 20
 Jun 2022 14:40:43 +0200
Message-ID: <e49b8686-6546-3b7f-dda3-6b4efb53d66c@gmx.de>
Date:   Mon, 20 Jun 2022 14:40:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 0/2] video: fbdev: Convert from PCI to generic power
 management
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>, linux-fbdev@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-pci@vger.kernel.org,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Vaibhav Gupta <vaibhavgupta40@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>
References: <20220608180956.GA407517@bhelgaas>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <20220608180956.GA407517@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:vj69s28dYdlp0K+pnq7qPonjf1zFbLqtRxTYLMIW3rnIz64pO0K
 GPro7+3Nk+TZXXbyqEDrpEeWKDeh1pazM91MBS6eDW/NULUOgMuFG0BrwPTOvIxgTCfJrw7
 cEO5qGh9+JrpeYB9NsDOx4Ql10Ly5RZ7Q9lWSywgjiC/0U4nVOh2MsaIe3kPxN4dnMD/R25
 JEhcKlgjDeLTMW5op8/8A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ZfI1ovxhKS4=:ICLoC3mKUmlhejdepfRPK4
 NvXiS9bgLm/qImY/psBb/kSI1M8w0FSG9t9TG/y/hSEkGOsLXP8kg3AjXEFVIZr23Gd0y+9Zm
 P4qDBwEjqjc3AJOeOMx8NU0yDJVkJ5TMju9bkmf377wPjv/6voayPgZL+Apbnr9f0262/JuVu
 raS95bjMEWP0PadIfiwDC6VPPUzhRnyt/KnXPyp7nwcAxKc6mKufp005hNlmzb4atyhjY3i42
 bIMrvqU9TR03xempBUFe3CiFz9wdKEfFwFGxWHGDWgJn+JYw282nJ4ewDZ9wXI6hdNFcYprwx
 864h/bsxlM/cFnIflK0QnGDeuoNbuATolEe63eBP3aD/L4Dsv2oUnVx6qCX9Py+mQhf30jn/W
 4HyDcnAU1bPGMNLO01oq7ateN+IjXpQSqOIRZDkC/xfr4A6Vg37q08CxB0rXNGMMNblCgbo6q
 VK8dij1RT4Hzpktb4GqEkE7EsPSVBWQv1V1y4Q/hLJLTmvw0UDOgJeVs0V8x7VM4mmhcNE0sO
 H+vWTXdSHvVbHPzFn4m+aUCrXPFqgyA7JlpLhddhUbTGzFVimKlwrv6/HNsESnBkvdA3Hx0RP
 3bDTgtrhQSDmPTFr2lS/o6iTJINP0n1sZqcuDLXh2UGXcHODKFGMaDKqRNjW1ytkXNAq06fAy
 4PHlNaqRkxtAma5WbXgQubbtRJ+57ri0vX8SxG/Fb2ydaY5CqhThi+AVh3ErPQ77rCUBHz0wD
 7fJtvWyXkOOhRlvHjFXzEib0/INKydLkFlbU6M59i0fOAJmSP4hvrrTtURu5o3Fp3525YDnbW
 +iTzhz++W8st9zOU/LB3RnpNsw6fIZkadMmjYK7iNYWkE140SSMl2d21SSgo7KZbxM049EXD/
 mdxeXshOFOH6QZare0AMC7h2d0jIwOzPxSiWXd5zAsp3wFomsp5SLjIg5EkpMmW1lgCI/wT8n
 8AUrDnyo6NXxIrr0HRUgQjgSI9cxBZ4Qpa05egXeakQBohdVz75IS/QvdZRuo7nswJk3sK/it
 JurjlrY3arwpEAaUy+E+OvP0TIvcIITBRax6CrmvD841dXNJvQJnMQ+YcKPZeqmK+Oi5ssuyN
 p2pAhU0OOYWC54xoyaIMG1kxIAM30kHYkbQMtBvsO20FLE1yDH0EhzNjA==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/8/22 20:09, Bjorn Helgaas wrote:
> On Wed, Jun 08, 2022 at 06:26:34PM +0200, Daniel Vetter wrote:
>> On Tue, Jun 07, 2022 at 06:11:10PM -0500, Bjorn Helgaas wrote:
>>> From: Bjorn Helgaas <bhelgaas@google.com>
>>>
>>> PCI-specific power management (pci_driver.suspend and pci_driver.resum=
e) is
>>> deprecated.  If drivers implement power management, they should use th=
e
>>> generic power management framework, not the PCI-specific hooks.
>>>
>>> No fbdev drivers actually implement PCI power management, but there ar=
e a
>>> cirrusfb has some commented-out references to it and skeletonfb has
>>> examples of it.  Remove these.
>>
>> Is this holding up some cleanup on your side and so would be easier to
>> merge these through the pci tree? If so
>>
>> Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
>>
>> for merging through your tree. Otherwise I guess Helge will get around =
to
>> pile them up for 5.20 (or 6.0) eventually.
>
> No particular rush and nothing depending on these.
>
> I added your ack to my local branch and if nothing happens for a
> while, I'll merge them via my tree.

I've been on vacation, but picked them up now.

Thanks!

Helge
