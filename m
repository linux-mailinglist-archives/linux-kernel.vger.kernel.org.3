Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB9434C9773
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 22:01:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238456AbiCAVCM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 16:02:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235428AbiCAVCJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 16:02:09 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D447C70337;
        Tue,  1 Mar 2022 13:01:27 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id q11so14464150pln.11;
        Tue, 01 Mar 2022 13:01:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bOIBe7yMZ/zlQEAPp3pgauJ01CCSXHq9UiJfLThwzls=;
        b=m4VXiXXvucihG1BfyCSBgKCpoAf7bhBPUcVd5IrlUqcBAGHfDiLwfTtbIlUnF4Atwb
         wcRx3TglHBg6sS1yR7Rhpe/w08SL5+q4J2nJLF5RmIhrttU9FUE6gphazEQ656d8qARF
         D5AVW+dQqIVyiFPifrhmmA2g0jl6oCE5gZa/I6x3MwhBZ2Zh6CwEZ5gmo0r4sf/cXzg8
         PPVOaeGHAWRxyZKAuipGFb9tX0jfrbPeO0TvrBjbnQ3DGKsVKelB2IJlCh9sD0pL4dVs
         nQ5MluWth6bP49ozpElfURqf9E36CSPeG11ig0kgbDLbT2aTuIf1EJKdm5fPAUQgWnzm
         mTpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bOIBe7yMZ/zlQEAPp3pgauJ01CCSXHq9UiJfLThwzls=;
        b=NR0oFBmOyBnNOH3aBriEvdGkR+X1q4AjkGmImA+Mgv5tKj5cXzUvVaF9Yv/uyadHR+
         iE9OL3t9nByXh8AMQ/yBf6IIiJ+whGas5srbi92PzOQTn5Tk8HEYunXvQGGnoGo3xJQC
         YPIJnzDHjxf/7qpbKp5+MUIJIEHvoDCNorNpjRfslGDi/a0xZCGSKwiS/xKBHHlKbjq9
         XEfbCc7hWgUoXyA9/g9MqOsRD82X7z8TfGFVQT08v2tvsgvXwAjhS5TC2dqkE8R9cxIk
         ucBta5E3QXt5FK8TJ+R7DzDIGk8wAhM/yXOcyqAvauLyuGi5f/fgkZXL95EkwXdJf+i3
         9X7Q==
X-Gm-Message-State: AOAM532fDhzTf6oNmCBSWsfDOiJ7NKOxfaYDuJ1vx2A1evI4uyNwAVoC
        5dnw+XW7UpKUaa9nY3wKjp8=
X-Google-Smtp-Source: ABdhPJxusFXIHW71NmkrejK1bs/xU2Fg5c+yf70kwofRE+uJGNcQbQTRIVy1oOGoXzTe+9Bf5OnySA==
X-Received: by 2002:a17:902:c14d:b0:14f:f1b9:1eab with SMTP id 13-20020a170902c14d00b0014ff1b91eabmr27002705plj.129.1646168487197;
        Tue, 01 Mar 2022 13:01:27 -0800 (PST)
Received: from google.com ([2620:15c:202:201:c110:510b:4b7b:d004])
        by smtp.gmail.com with ESMTPSA id q9-20020a056a00088900b004e03b051040sm18280946pfj.112.2022.03.01.13.01.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 13:01:26 -0800 (PST)
Date:   Tue, 1 Mar 2022 13:01:23 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Sachi King <nakato@nakato.io>, Chen Yu <yu.c.chen@intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] platform/surface: surfacepro3_button: don't load on
 amd variant
Message-ID: <Yh6Joy2HDnsuK6LN@google.com>
References: <20211109081125.41410-1-nakato@nakato.io>
 <20211109081125.41410-2-nakato@nakato.io>
 <CAHp75Vcw-ARNZCRRJGzbQ7xc3ZB=98eFCuEFc4cj5W3vAj5EZw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75Vcw-ARNZCRRJGzbQ7xc3ZB=98eFCuEFc4cj5W3vAj5EZw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 09, 2021 at 11:12:34AM +0200, Andy Shevchenko wrote:
> On Tue, Nov 9, 2021 at 10:11 AM Sachi King <nakato@nakato.io> wrote:
> >
> > The AMD variant of the Surface Laptop report 0 for their OEM platform
> > revision.  The Surface devices that require the surfacepro3_button
> > driver do not have the _DSM that gets the OEM platform revision.  If the
> > method does not exist, load surfacepro3_button.
> 
> ...
> 
> >   * Surface Pro 4 and Surface Book 2 / Surface Pro 2017 use the same device
> >   * ID (MSHW0040) for the power/volume buttons. Make sure this is the right
> > - * device by checking for the _DSM method and OEM Platform Revision.
> > + * device by checking for the _DSM method and OEM Platform Revision DSM
> > + * function.
> 
> Not sure what this change means (not a native speaker).
> 
> ...
> 
> > -       dev_dbg(&dev->dev, "OEM Platform Revision %llu\n", oem_platform_rev);
> 
> I think this is useful to have.
> 
> What about leaving it as is for debugging purposes and just replacing
> the last test?

I agree it is nice to be able to print it for debug purposes, but it has
to be fetched separately, as with the proposed change we are not reading
it.

If I am understanding the change it wants to call acpi_dsm_check()
to verify whether MSHW0040_DSM_GET_OMPR function exists at all (which is
done by reading _DSM MSHW0040_DSM_UUID, revision MSHW0040_DSM_REVISION,
function 0. Only if function 0 indicates that function
MSHW0040_DSM_GET_OMPR is supported in this _DSM, we can read it to get
the real version number, which can be 0.

Treating 0 as an invalid version as it was done in original change is
wrong.

I propose we combine the old and new code, call acpi_dsm_check() and
bail if it returns false, otherwise proceed to calling
acpi_evaluate_dsm_typed() and dev_dbg() the version.

Sachi, are you going to update the patch? You do not need to adjust the
surface driver as Hans is getting rid of it.

Thanks.

-- 
Dmitry
