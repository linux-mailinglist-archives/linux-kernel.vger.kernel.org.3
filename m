Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B33F249A279
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 03:00:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2362558AbiAXXme (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 18:42:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:59724 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1843602AbiAXXFF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 18:05:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643065505;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=C5KkQSdltS+b36FURaUjP42JJqZfoZP4iH99cfdSAq0=;
        b=OqVxmRA8ebeDmciLYhGO9MDeIJjoNhxYi42Ywlh29+cFKUUSkChRV8HRbAVIjm4uYlY+hO
        0NiU1ErwZSNT5icikeWIrmLFM5mbScsVAa0hmXu8KPx0sjLkyNm2zECbLmM3wgqf1DoGEj
        Aem8PCYmQxJ0GBk8fLx6UndTQMZEH7g=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-50-p5P0bB2dNjOalbMCdfhH4w-1; Mon, 24 Jan 2022 18:05:04 -0500
X-MC-Unique: p5P0bB2dNjOalbMCdfhH4w-1
Received: by mail-oi1-f197.google.com with SMTP id w8-20020aca6208000000b002c7da950057so10016389oib.5
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 15:05:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=C5KkQSdltS+b36FURaUjP42JJqZfoZP4iH99cfdSAq0=;
        b=jEhpOmPTC2g2dZ7Gsm7i5FFyuWJeGzmiaGulcDaHfqvp07NZLAsOYI0OTkXx02PJ2h
         JnxCouhFf5GnqqXkvULaQZT6WGC7w+xLC7chJpCUjBhGUxacKVeMVPQVTQROsE46SQOV
         hWwrxMtDVizIXgRNAfFs7V8DOMOUqM0USwilGz8v3epl/LUFe1zoZPUpiKph7whtBuwy
         SoazeaqE251s/nknRV1Ru6/MoX313is3aWpc396W0sVXpuaOrRPmFLUTB7+7i/LT6yH/
         OwsaSOLfYFIpyk2LUhrwnq3WRXlJ7FRiAX7V2buY9aB1k2033gntqgT18Hy+Y4NnPXhR
         jJ1g==
X-Gm-Message-State: AOAM533GRv4AfJIzqe1gAwf7dcmiwNPJ0DmM8QvHrX5n6iDa7HCBosux
        WgHDLtKi0SsqeGtOrqcESovjfmdxZvwFqmua+oREW/9BCJz2VKqaHuCrnHbBal7h1Fm6iCIf8sP
        mmvl9EapXogVktd3p3U/X0NQJ
X-Received: by 2002:a9d:6b84:: with SMTP id b4mr12911520otq.332.1643065502920;
        Mon, 24 Jan 2022 15:05:02 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyoe8IVXWPjUFvwstPJ3Z0pnSu6YYkMxx7q6HeElC6QHFJC3V0xDo7mHvG8p7rZTtcIbUWInw==
X-Received: by 2002:a9d:6b84:: with SMTP id b4mr12911495otq.332.1643065502632;
        Mon, 24 Jan 2022 15:05:02 -0800 (PST)
Received: from treble ([2600:1700:6e32:6c00::45])
        by smtp.gmail.com with ESMTPSA id 124sm6093857oif.7.2022.01.24.15.05.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jan 2022 15:05:02 -0800 (PST)
Date:   Mon, 24 Jan 2022 15:04:58 -0800
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@intel.com, luto@kernel.org, peterz@infradead.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, knsathya@kernel.org, pbonzini@redhat.com,
        sdeep@vmware.com, seanjc@google.com, tony.luck@intel.com,
        vkuznets@redhat.com, wanpengli@tencent.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2 08/29] x86/tdx: Handle in-kernel MMIO
Message-ID: <20220124230458.xm5dn6jdgti7qurq@treble>
References: <20220124150215.36893-1-kirill.shutemov@linux.intel.com>
 <20220124150215.36893-9-kirill.shutemov@linux.intel.com>
 <20220124193008.gfaq5ppegx5nfomd@treble>
 <20220124220821.4bgf6i3qfhj6mrht@black.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220124220821.4bgf6i3qfhj6mrht@black.fi.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2022 at 01:08:21AM +0300, Kirill A. Shutemov wrote:
> > The return code conventions are still all mismatched and confusing:
> > 
> > - Most tdx_handle_*() handlers return bool (success == true)
> > 
> > - tdx_handle_mmio() returns int (success > 0)
> 
> Right, all tdx_handle_* are consistent: success > 0.

Non-zero success is not the same as above-zero success.  The behavior is
not interchangeable.

> > - tdx_mmio*() helpers return bool (success == false)
> 
> And what is wrong with that? Why do you mix functions that called in
> different contexts and expect them to have matching semantics?

Why would you expect the reader of the code to go investigate the weird
return semantics of every called function?

And "success == false" is just plain confusing, I haven't seen that one.

> > I still don't see any benefit in arbitrarily mixing three different
> > return conventions, none of which matches the typical kernel style for
> > returning errors, unless the goal is to confuse the reader and invite
> > bugs.
> 
> Okay, we have an disagreement here.
> 
> I picked a way to communicate function result as I see best fits the
> situation. It is a judgement call.
> 
> I will adjust code if maintainers see it differently from me. But until
> then I don't see anything wrong here.
> 
> > There is precedent in traps.c for some handle_*() functions to return
> > bool (success == true), so if the goal is to align with that
> > semi-convention, that's ok.  But at the very least, please do it
> > consistently:
> > 
> >   - change tdx_mmio*() to return true on success;
> > 
> >   - change tdx_handle_mmio() to return bool, with 'len' passed as an
> >     argument.
> 
> Hard no.
> 
> Returning a value via passed argument is the last resort for cases when
> more than one value has to be returned. In this case the function is
> perfectly capable to communicate result via single return value.
> 
> I don't see a reason to complicate the code to satisfy some "typical
> kernel style".

It's a convention for a reason.

> > Or, even better, just change them all to return 0 on success like 99+%
> > of error-returning kernel functions.
> 
> Citation needed. 99+% looks like an overstatement to me.

From Documentation/process/coding-style.rst:

16) Function return values and names
------------------------------------

Functions can return values of many different kinds, and one of the
most common is a value indicating whether the function succeeded or
failed.  Such a value can be represented as an error-code integer
(-Exxx = failure, 0 = success) or a ``succeeded`` boolean (0 = failure,
non-zero = success).

Mixing up these two sorts of representations is a fertile source of
difficult-to-find bugs.  If the C language included a strong distinction
between integers and booleans then the compiler would find these mistakes
for us... but it doesn't.  To help prevent such bugs, always follow this
convention::

	If the name of a function is an action or an imperative command,
	the function should return an error-code integer.  If the name
	is a predicate, the function should return a "succeeded" boolean.

For example, ``add work`` is a command, and the add_work() function returns 0
for success or -EBUSY for failure.  In the same way, ``PCI device present`` is
a predicate, and the pci_dev_present() function returns 1 if it succeeds in
finding a matching device or 0 if it doesn't.

-- 
Josh

