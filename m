Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0E6B473AF7
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 03:51:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244879AbhLNCvN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 21:51:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244875AbhLNCvF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 21:51:05 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AF50C061751;
        Mon, 13 Dec 2021 18:51:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=JQteDTasuhERiQdoO8h3MwzFI2xTS+/dvlyONH5weSI=; b=kvQPmmwpeorODloDO5Gg4cc0/E
        aKAj5d1E3f69cYwjZJPzHkDA5CQ/bAUtuRSmnWtmBk0ffwb7xKm5sQ/4dlbUUTXN4XkxyAYRrCHxH
        RtbxI312qTc2c0S+Pn/Z+NXqQTY3mi0G2XlJNwqG6mbU97ghbdUMhv2z2G5/a25USoaX7Fg4qphEC
        yXdtqUP1RY6SvFi/9dfKWM11wfKLsNgFiSAL2ysCmI0NaFxhqOeSajUUB6uRT19d9Zjb3wonBTld9
        iuEgiNwSWe6/yorJtBw+Go0iBKZnwGXamTRKShZX60TMlOgxKw97UVxxrXYsGAYw8wrQjxVMCslyd
        YEEYGA9Q==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mwxu4-001ElU-ME; Tue, 14 Dec 2021 02:50:57 +0000
Message-ID: <623bad19-49e5-ee34-910c-f3caf39319f5@infradead.org>
Date:   Mon, 13 Dec 2021 18:50:51 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH 5/3] docs: sphinx/kfigure.py: Delegate inkscape msgs to
 kernellog
Content-Language: en-US
To:     Akira Yokosawa <akiyks@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <de8def13-efbc-1d98-acb5-5cc1f6902e4b@gmail.com>
 <ea41dd96-124a-9132-7659-1ae04d82188b@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <ea41dd96-124a-9132-7659-1ae04d82188b@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/13/21 18:34, Akira Yokosawa wrote:
> Instead of redirecting to /dev/null, capture inkscape messages and
> output them via kernelloc.verbose or kerneldoc.warn depending on the

                  kernellog.verbose or kernellog.warn

> exit code.
> 
> Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> Cc: Jonathan Corbet <corbet@lwn.net>
> ---
> Hi Mauro,
> 
> On second thought, I took the path of delegating inkscape warnings
> to kernellog.
> 
> Now you can see those warning messages by "SPHINXOPTS=-v".
> 
> Does this approach sound reasonable to you?
> 
>         Thanks, Akira
> --
>  Documentation/sphinx/kfigure.py | 28 +++++++++++++---------------
>  1 file changed, 13 insertions(+), 15 deletions(-)
> 
> diff --git a/Documentation/sphinx/kfigure.py b/Documentation/sphinx/kfigure.py
> index dbe75ee8ae61..a275ee0fec02 100644
> --- a/Documentation/sphinx/kfigure.py
> +++ b/Documentation/sphinx/kfigure.py
> @@ -126,9 +126,6 @@ rsvg_convert_cmd = None
>  inkscape_cmd = None
>  # Inkscape prior to 1.0 uses different command options
>  inkscape_ver_one = False
> -# Show warning from inkscape(1), enabled by setting env var
> -# SPHINX_SHOW_INKSCAPE_WARN
> -inkscape_show_warn = False
>  
>  
>  def setup(app):
> @@ -178,7 +175,7 @@ def setupTools(app):
>      This function is called once, when the builder is initiated.
>      """
>      global dot_cmd, dot_Tpdf, convert_cmd, rsvg_convert_cmd   # pylint: disable=W0603
> -    global inkscape_cmd, inkscape_ver_one, inkscape_show_warn  # pylint: disable=W0603
> +    global inkscape_cmd, inkscape_ver_one  # pylint: disable=W0603
>      kernellog.verbose(app, "kfigure: check installed tools ...")
>  
>      dot_cmd = which('dot')
> @@ -211,12 +208,6 @@ def setupTools(app):
>          rsvg_convert_cmd = None
>          dot_Tpdf = False
>  
> -        try:
> -            if os.environ['SPHINX_SHOW_INKSCAPE_WARN']:
> -                inkscape_show_warn = True
> -        except KeyError:
> -            pass
> -
>      else:
>          if convert_cmd:
>              kernellog.verbose(app, "use convert(1) from: " + convert_cmd)
> @@ -384,14 +375,21 @@ def svg2pdf(app, svg_fname, pdf_fname):
>          else:
>              cmd = [inkscape_cmd, '-z', '--export-pdf=%s' % pdf_fname, svg_fname]
>  
> -    # use stdout and stderr from parent
> -    if inkscape_show_warn:
> -        exit_code = subprocess.call(cmd)
> -    else:
> -        exit_code = subprocess.call(cmd, stderr=subprocess.DEVNULL)
> +    try:
> +        warning_msg = subprocess.check_output(cmd, stderr=subprocess.STDOUT)
> +        exit_code = 0
> +    except subprocess.CalledProcessError as err:
> +        warning_msg = err.output
> +        exit_code = 1
> +        pass
>  
>      if exit_code != 0:
>          kernellog.warn(app, "Error #%d when calling: %s" % (exit_code, " ".join(cmd)))
> +        kernellog.warn(app, "Warning msg from inkscape: %s" % str(warning_msg, 'utf-8'))
> +    if warning_msg:
> +        kernellog.verbose(app, "Warning msg from inkscape (likely harmless):\n%s"
> +                          % str(warning_msg, 'utf-8'))
> +
>      return bool(exit_code == 0)
>  
>  def svg2pdf_by_rsvg(app, svg_fname, pdf_fname):
> 

-- 
~Randy
