Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D18FA52DFD6
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 00:13:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245390AbiESWN1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 18:13:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237755AbiESWNZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 18:13:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F01E5AEDD;
        Thu, 19 May 2022 15:13:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0E567B828AA;
        Thu, 19 May 2022 22:13:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CCD3C385AA;
        Thu, 19 May 2022 22:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652998401;
        bh=EhDdM7epHX9M88QHEaZ6KEcngcsL6EzezvL86BA/qvk=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=mSMnHB2LYlct4HqsAGisrXJrlzO/233uMmDVPNlG5O41+0Pq3B6Fg7pwj2pBs4VFa
         F+AcqKhP0MnJJAfxhY/9K0QgN5QlR3v6Vdrxa7VUsTgfpOovPy6N001uHdZ7dnyYNW
         +laAig2cWGmmSHlni2WZIB4FdVX2IyC2uE8rZC0R8L37KxTtuRrKpYpTLRBRiEehen
         3fYS9URY461hYeY0L+ewR4ZOxhz/3Id0RXNOHW7w94KuQ4TfWR+QmDQaKz/GguS8A8
         XskhX9wx5VR9JS9Xtd/5XiPtkU0nRjrFGIhQxzJX4U+xbn00+lSihsEJz8FGJhPUyr
         GNVs/Cc4hXNEA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220519073330.7187-1-krzysztof.kozlowski@linaro.org>
References: <20220519073330.7187-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v2 1/3] rpmsg: qcom: glink: replace strncpy() with strscpy_pad()
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-remoteproc@vger.kernel.org
Date:   Thu, 19 May 2022 15:13:19 -0700
User-Agent: alot/0.10
Message-Id: <20220519221321.9CCD3C385AA@smtp.kernel.org>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Krzysztof Kozlowski (2022-05-19 00:33:28)
> The use of strncpy() is considered deprecated for NUL-terminated
> strings[1]. Replace strncpy() with strscpy_pad(), to keep existing
> pad-behavior of strncpy, similarly to commit 08de420a8014 ("rpmsg:
> glink: Replace strncpy() with strscpy_pad()").  This fixes W=3D1 warning:
>=20
>   In function =E2=80=98qcom_glink_rx_close=E2=80=99,
>     inlined from =E2=80=98qcom_glink_work=E2=80=99 at ../drivers/rpmsg/qc=
om_glink_native.c:1638:4:
>   drivers/rpmsg/qcom_glink_native.c:1549:17: warning: =E2=80=98strncpy=E2=
=80=99 specified bound 32 equals destination size [-Wstringop-truncation]
>    1549 |                 strncpy(chinfo.name, channel->name, sizeof(chin=
fo.name));
>=20
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strncp=
y-on-nul-terminated-strings
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>=20
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>
