Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDA4C4ED5E9
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 10:40:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233126AbiCaIly (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 04:41:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232656AbiCaIls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 04:41:48 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FA971F6868
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 01:40:01 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id r13so46562056ejd.5
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 01:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0vypsesrFVw05o/okqipuSd+z+xTlFbPotfvsFH4ViQ=;
        b=WprbdhTnLfNYovVIDzsSprkIwWdD7R15mI7FcSmMYAyznIhiq+tNGAsX+wwb4+6Q5Y
         CvoJ5Irs0Ge7mLOibysBjG2CMmciRlPjCLohh9ja9ILTC5zECMNm4ffBPFLInQOP/Va0
         axf5QdSliHO82iU5w08m5VtF9xY9HJsZXPJQOkIn7uOz29kSxD+lmd0hRiM2zH6s7dJV
         p5u3OWriLxe3b43EoldZ3zrq9MSo0eLHoKQPwNyQf7/V80YC2YbmimuCewzOlbbgERVm
         wDDmL1iMTlbmxxYZ8xCKh4RUdEltFREUue38Afhl1+yZ3qMYTkgwj9R1VSgrBYB987rD
         ZrGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0vypsesrFVw05o/okqipuSd+z+xTlFbPotfvsFH4ViQ=;
        b=qTv7vqmszGcscysBRJrv755dzEdjyI+FHjA7ywsZfWUD1FwpraEuG7wDGDYIJtrVMS
         iV+tH7coLHVwOrqZdGeDuxSxpya6iG6AUDR/P7kwj5mItqK1nve0IY+yCeBNfhxBvUX2
         M7j0Zq4V/7IlO9y+/0T2/BQ2/+MbDFjY1dQgjh8GQw6kStSZSAQuqIowvEQVaMCPXDG1
         p2LEd2bNpgn54bI1fo0KW49/xcJVHeNgC7Hu/rzJNizsFy6X+uFXw2x95Wki9FryoCeI
         u0F+oZTJMLNptTEVBOSj4KTkhTnQ53cUiezdg270v7JqGSfpwOLOqRp5mDBuitArlGQH
         6bGA==
X-Gm-Message-State: AOAM533CKegu0JG6zcdzW/+oLdl8bed+OqeqUVAuB6yb0NGFU+er7gyj
        3yCsEf1pg0U+LWTS0Y0rAd4dbLpaFO8x4189YEa8wQ==
X-Google-Smtp-Source: ABdhPJycwRpdT8DwvNwZzsriAA9fKXV0997Hib2d4YqGN0rP7WNwy/zT2CRQf03nfWzvO5PPV5GJbtmHERlHr5JVw2k=
X-Received: by 2002:a17:907:97c5:b0:6da:c285:44f5 with SMTP id
 js5-20020a17090797c500b006dac28544f5mr4070851ejc.208.1648715999821; Thu, 31
 Mar 2022 01:39:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220330211712.2067044-1-wonchung@google.com>
In-Reply-To: <20220330211712.2067044-1-wonchung@google.com>
From:   Won Chung <wonchung@google.com>
Date:   Thu, 31 Mar 2022 01:39:47 -0700
Message-ID: <CAOvb9yi2sobmM6AvAmEVPAYO_aZN4ph5yuHv5tHhUj3msYovkw@mail.gmail.com>
Subject: Re: [PATCH v2] misc/mei: Add NULL check to component match callback functions
To:     Tomas Winkler <tomas.winkler@intel.com>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Benson Leung <bleung@chromium.org>,
        Prashant Malani <pmalani@chromium.org>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I need to resend v3 with flags corrected. Sorry for confusion.

Won

On Wed, Mar 30, 2022 at 2:17 PM Won Chung <wonchung@google.com> wrote:
>
> Component match callback functions need to check if expected data is
> passed to them. Without this check, it can cause a NULL pointer
> dereference when another driver registers a component before i915
> drivers have their component master fully bind.
>
> Fixes: 1e8d19d9b0dfc ("mei: hdcp: bind only with i915 on the same PCH")
> Fixes: c2004ce99ed73 ("mei: pxp: export pavp client to me client bus")
> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Signed-off-by: Won Chung <wonchung@google.com>
> ---
> Changes from v1:
> - Add "Fixes" tag
> - Send to stable@vger.kernel.org
>
>  drivers/misc/mei/hdcp/mei_hdcp.c | 2 +-
>  drivers/misc/mei/pxp/mei_pxp.c   | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/misc/mei/hdcp/mei_hdcp.c b/drivers/misc/mei/hdcp/mei_hdcp.c
> index ec2a4fce8581..843dbc2b21b1 100644
> --- a/drivers/misc/mei/hdcp/mei_hdcp.c
> +++ b/drivers/misc/mei/hdcp/mei_hdcp.c
> @@ -784,7 +784,7 @@ static int mei_hdcp_component_match(struct device *dev, int subcomponent,
>  {
>         struct device *base = data;
>
> -       if (strcmp(dev->driver->name, "i915") ||
> +       if (!base || !dev->driver || strcmp(dev->driver->name, "i915") ||
>             subcomponent != I915_COMPONENT_HDCP)
>                 return 0;
>
> diff --git a/drivers/misc/mei/pxp/mei_pxp.c b/drivers/misc/mei/pxp/mei_pxp.c
> index f7380d387bab..e32a81da8af6 100644
> --- a/drivers/misc/mei/pxp/mei_pxp.c
> +++ b/drivers/misc/mei/pxp/mei_pxp.c
> @@ -131,7 +131,7 @@ static int mei_pxp_component_match(struct device *dev, int subcomponent,
>  {
>         struct device *base = data;
>
> -       if (strcmp(dev->driver->name, "i915") ||
> +       if (!base || !dev->driver || strcmp(dev->driver->name, "i915") ||
>             subcomponent != I915_COMPONENT_PXP)
>                 return 0;
>
> --
> 2.35.1.1021.g381101b075-goog
>
