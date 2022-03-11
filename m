Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5525B4D6382
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 15:34:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349392AbiCKOfj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 09:35:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237079AbiCKOfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 09:35:37 -0500
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB6901C8D80;
        Fri, 11 Mar 2022 06:34:34 -0800 (PST)
Received: by mail-qk1-x732.google.com with SMTP id v15so7068786qkg.8;
        Fri, 11 Mar 2022 06:34:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KCfOxllSA7l93UmzB1yv+vpAiUm9dySLpad7xZoiNto=;
        b=M9PLowjLzy/DJ8Nkeohqr1x+5EPPYhY17Vk0h8gES5lYD7lQk9WimboHcEHljtGVCt
         hGLc6ptIKb4DpYDxKWxlRtgUzSSoEu1OB0jkG6OY24SM3uNcuVad54K9v7xsYJPzELrA
         A8j2YHazES574D86dryMXaOhdZttmTzzKBlf94nK/EJ73i8IJhycxc3CxWjL/+pgvOrT
         fDVeCLYVCDhOI4evfMlmaiNZ9OqhkghYsHlazuSRQmeoU6D6rntCLCkByRxhn2pGVuaT
         ag0Zo/V45F+YfbDRGeyHTKMQfqCHqKgFCNkkezkmcqMVTu72/jVkcmZLjhYsHPXCPqnd
         jQ9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KCfOxllSA7l93UmzB1yv+vpAiUm9dySLpad7xZoiNto=;
        b=sYooxeZ+kWPt3DxeDwaQOuuZlXtFuazkjS4YR8aLTpauj1ZpW0F2bCuGkaaB5hWCNO
         U9/s2kHJFa/lbnS4UywVGRpO7KhZf3NWy6SLQfHe2wXl47cHeVEVUw1XiKl2q6vuyae6
         q2u/L4pKEPEeiVrEestrEhMKG2Ew5H82m8UyF0xEzPeOwWHTH5xTg2cPSlfcZzfoziR6
         aJYoyxQfC/udQjiBcaNauIChNGWzz4Z7hV0rSb/4i+46MaB4pAsGGTMcBObSDXCTbur9
         Ibiu8yAhfbdaj/mBStl8ZGhJJoJZ/Aic6GpCbviHffOPwqScRWhkmyCv7LsHv4JdrLZW
         dICA==
X-Gm-Message-State: AOAM533TBQhUdEA+EMy85WN5hx+1O9HqZazK276LpecfGaw8QYXoBUof
        32mBRhJ2HEXweC2bSSk5rLLEKVuLOls=
X-Google-Smtp-Source: ABdhPJw3Tr6RnWl6Tl63sVVww0rKudDV24bsZRKxFVZDlsP+EBcmgI4GkUhji2b5sqqo9Rlq4D37gg==
X-Received: by 2002:a37:ab11:0:b0:67d:6742:2988 with SMTP id u17-20020a37ab11000000b0067d67422988mr4294770qke.51.1647009273873;
        Fri, 11 Mar 2022 06:34:33 -0800 (PST)
Received: from localhost (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id l8-20020a05622a174800b002e1a30533e2sm5196918qtk.8.2022.03.11.06.34.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 06:34:33 -0800 (PST)
Date:   Fri, 11 Mar 2022 09:34:31 -0500
From:   Trevor Woerner <twoerner@gmail.com>
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org
Subject: Re: [PATCH 3/3] serial: 8250_fintek.c: Clean up set_termios() message
Message-ID: <20220311143431.GB38527@localhost>
References: <20220311070203.18159-3-twoerner@gmail.com>
 <7bf43ee7-549e-c98c-1ca9-b5060124c94b@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7bf43ee7-549e-c98c-1ca9-b5060124c94b@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2022-03-11 @ 10:23:22 AM, Jiri Slaby wrote:
> On 11. 03. 22, 8:02, Trevor Woerner wrote:
> > Clean up the status message that is given in the case where a custom
> > termios() is not installed.
> > 
> > Signed-off-by: Trevor Woerner <twoerner@gmail.com>
> > ---
> >   drivers/tty/serial/8250/8250_fintek.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/tty/serial/8250/8250_fintek.c b/drivers/tty/serial/8250/8250_fintek.c
> > index 03ad2354d808..dcab23d1965e 100644
> > --- a/drivers/tty/serial/8250/8250_fintek.c
> > +++ b/drivers/tty/serial/8250/8250_fintek.c
> > @@ -333,7 +333,7 @@ static void fintek_8250_set_termios(struct uart_port *port,
> >   	default:
> >   		/* Don't change clocksource with unknown PID */
> >   		dev_warn(port->dev,
> > -			"%s: pid: %x Not support. use default set_termios.\n",
> > +			"%s: chipID: %x not supported; using default set_termios.\n",
> >   			__func__, pdata->pid);
> 
> So the variable calls it PID, the comment calls it PID and you change the
> report to chipID. Why?

The datasheet doesn't contain the string/identifier PID anywhere. The hex
value stored in pdata->pid is the contents of what the datasheet refers to as
the Chip ID Register in the Global Control Registers. Identifying this value
as the chipID would probably make more sense to a person who is trying to
understand what this value is, provided they're also reading through the
datasheet at the same time.

I was considering a patch that would change "pid" to "chipID" in
8250_fintek.c, would that be a better way to go? I guess pid stands for "part
ID" or "product ID", but neither of those appear in the datasheet either.

> thanks,
> -- 
> js
> suse labs
